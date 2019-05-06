# News Release Log
The is a web application that allows users to track news releases

## Workflow of a news release log


### Development Environment

#### (We assume that you have already installed docker or use this [how to install docker link](https://docs.docker.com/machine/install-machine/#install-bash-completion-scripts))

#### Then run the following commands to bring up the instances after cloning the code locally

    docker-compose up


#### Then run the following commands to bring down the instances after cloning the code locally

    docke-compose down

#### Once the web and db instances are up without any issues create the db and run the migrations

    docker-compose exec web bundle exec rake db:seed
