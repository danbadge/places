Places
======
A map displaying a bunch of restaurants, bars and cafes.

Local dev setup
===============

https://devcenter.heroku.com/articles/heroku-postgresql#local-setup

> sudo apt-get install postgresql

> sudo -u postgres createuser <username> --superuser

> sudo -u postgres createdb --owner=<username> <username>

> psql

- should run without error

then you can do

> rake db:create db:migrate

> rails server