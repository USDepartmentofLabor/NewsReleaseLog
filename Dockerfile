FROM phusion/passenger-ruby25

# Set correct environment variables.
ENV HOME /root
ENV APP_HOME /home/app/webapp

# Get the update packages and tzdata
RUN apt-get update && apt-get install -y tzdata

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

EXPOSE 80 443

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD env-config/news_log.conf /etc/nginx/sites-enabled/news_log.conf

ADD env-config/mongodb-env.yml $APP_HOME/conf/mongoid.yml

RUN rvm-exec 2.5.1 bundle install

RUN /bin/bash -l -c "rvm use 2.5.1; rvm @global do gem install bundler"

#RUN bundle exec rails assets:precompile

COPY --chown=app:app . $APP_HOME

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
