Places
======
A map displaying a bunch of restaurants, bars and cafes.

Local dev setup
===============

https://devcenter.heroku.com/articles/heroku-postgresql#local-setup

> sudo apt-get install postgresql

> sudo -u postgres createuser your_username --superuser

> sudo -u postgres createdb --owner=your_username your_username

This should run without error

> psql

Then you can do

> rake db:create db:migrate

> rails server

https://maps.googleapis.com/maps/api/place/details/json?placeid=ChIJe29QNB0QdkgR5Kkx_0-jdo4&key=AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss

https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyA6ww-54JxL_krZ0VyA5cCS8ALCgEowhss&keyword=the%20ledbury&location=51.511918,-0.127501&rankby=distance


Docker Setup
============

> brew install boot2docker
> brew install fig

> boot2docker up

one offs:
> boot2docker init
> boot2docker start
this last one gets some environment variables

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/dwatts/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

these need setting
