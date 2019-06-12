FROM opanewsrelease-local.artifactory.dol.gov/rhelimage:latest

## Enabling RHEL 7 repositories to install packages
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms \
    rhel-7-server-optional-rpms \
    rhel-7-server-extras-rpms \
    rhel-7-server-rpms \
    rhel-7-server-eus-rpms

# Update the base packages
RUN yum update -y && yum clean all

## Install NodeJS 8
RUN yum install -y gcc-c++ make \
 && curl -sL https://rpm.nodesource.com/setup_8.x | bash - \
 && yum install -y nodejs \
 && yum clean all

## Install Yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo \
 && yum install -y yarn \
 && yum clean all

## Install stable ruby with rails
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
SHELL [ "/bin/bash", "-l", "-c" ]
RUN \curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
RUN source /etc/profile.d/rvm.sh && rvm reload

RUN yum install -y patch autoconf automake bison bzip2 libffi-devel libtool patch readline-devel ruby sqlite-devel zlib-devel openssl-devel && yum clean all
RUN rvm install ruby-2.6.3 --no-docs

RUN rvm use --default 2.6.3

# Set environment variables
ENV HOME /root
ENV APP_HOME /webapp
ENV RAILS_ENV production
ENV RACK_ENV production

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY ./Gemfile Gemfile.lock $APP_HOME/

RUN bundle install --clean --deployment

## Adding Passenger Repo
RUN curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

RUN yum-config-manager --enable epel cr

RUN yum install -y libcurl-devel \
    epel-release \
 && yum clean all

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum clean all

RUN yum install -y nginx passenger && yum clean all

RUN yum clean packages && yum clean metadata && yum clean headers

COPY . $APP_HOME

## Copy environment specific files into image
ADD env-config/news_log.conf /etc/nginx/sites-enabled/news_log.conf
ADD env-config/dhparam.pem /etc/pki/tls/certs/dhparams.pem
ADD env-config/star_dol_gov.crt /etc/pki/tls/certs/star_dol_gov.crt
ADD env-config/newslog.gov.key /etc/pki/tls/private/newslog.gov.key
ADD env-config/secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD env-config/mongodb-env.yml $APP_HOME/config/mongoid.yml
ADD env-config/seeds.rb $APP_HOME/db/seeds.rb
ADD env-config/import_from_excel.rake $APP_HOME/lib/tasks/import_from_excel.rake

COPY . $APP_HOME

RUN chmod 600 /etc/pki/tls/certs/star_dol_gov.crt /etc/pki/tls/private/newslog.gov.key /etc/pki/tls/certs/dhparams.pem

RUN RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rake assets:precompile

CMD ["passenger", "start"]

EXPOSE 80 443
