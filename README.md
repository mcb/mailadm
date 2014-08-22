mailadm
=======

Mail Admin for Dovecot / Postfix


## Overview

mailadm consists of two parts:
- the admin interface
- Rake tasks to create config files for dovecot/postfix

## Admin interface
Still work in progress, move along. Nothing to see here.

## Rake Tasks
You might want to invoke the Rake tasks with a simple
``` bundle exec rake -vT``` to display available tasks.

### DB - Migrations

``` bundle exec rake db:migrate ``` will setup the database with the given credentials. Please alter lib/config/database.yml accordingly.

As of now, only postgres is supported. Please do not ask why, we want to setup a serious mail server, don't we?

### Template generation
``` bundle exec rake templates:generate``` will create a template_out directory in lib, bundling all config files needed with the correct structure.

## Disclaimer

This is a work in progress, these config files might not be secure enough for your purpose. Please adjust settings accordingly. 
