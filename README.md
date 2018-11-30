# README

See https://regale.herokuapp.com/

# Heroku

## Add an admin user

Define an `ADMIN_EMAIL` ENV variable. The user with this email address is the first administrator and can assign the same role to other users.


# SendGrid

The production mode of this application uses [SendGrid](http://sendgrid.com) for sending mails.

# TypeScript

I was hoping to integrate TS into this project, but extracting the logic for rendering a [donut chart](https://www.patternfly.org/pattern-library/data-visualization/donut-chart) into a React component made me find out that the [example used by PatternFly](https://www.patternfly.org/pattern-library/data-visualization/donut-chart/#code) uses a jQuery plugin defined on the global $-object, which is not accessible inside the class created with TS. Apart from this however, [integrating TypeScript](https://github.com/rails/webpacker/blob/master/docs/typescript.md) was quite easy.

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

