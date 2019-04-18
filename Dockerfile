FROM phusion/passenger-ruby25:0.9.35

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp
ENV RAILS_ENV production
ENV RACK_ENV production
#Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Get the update packages and tzdata
RUN apt-get update && apt-get install -y tzdata yarn nodejs


# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

EXPOSE 80 443

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

COPY --chown=app:app . $APP_HOME

# Copy environment specific files
ADD env-config/news_log.conf /etc/nginx/sites-enabled/news_log.conf
ADD env-config/dhparam.pem /etc/pki/tls/certs/dhparams.pem
ADD env-config/star_dol_gov.crt /etc/pki/tls/certs/star_dol_gov.crt
ADD env-config/newslog.gov.key /etc/pki/tls/private/newslog.gov.key
ADD env-config/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD env-config/mongodb-env.yml $APP_HOME/config/mongoid.yml
ADD env-config/seeds.rb $APP_HOME/db/seeds.rb
ADD env-config/import_from_excel.rake $APP_HOME/lib/tasks/import_from_excel.rake

#Update file ownerships
RUN chmod 600 /etc/pki/tls/certs/star_dol_gov.crt /etc/pki/tls/private/newslog.gov.key /etc/pki/tls/certs/dhparams.pem
RUN chown app:app $APP_HOME/config/mongoid.yml

RUN rvm-exec 2.5.1 bundle install
RUN /bin/bash -l -c "rvm use 2.5.1; rvm @global do gem install bundler"
RUN RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rake assets:precompile
RUN chown -R app:app $APP_HOME/tmp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
