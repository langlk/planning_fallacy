# Planning Fallacy

### _Epicodus Project in Ruby on Rails, December 18, 2017_

### By Kelsey Langlois

## Description

_This is an app to help people compensate for the Planning Fallacy. It tracks how late a user is to events, and uses the information to provide recommendations for when to leave for events in order to arrive on time._

## Installation and Setup

To install on your own machine, follow the instructions below:

* Clone this repository.
* Run the following commands in the project root directory:
  ```
  bundle update
  rake db:setup
  rails s
  ```
* Open ```localhost:3000``` in your web browser

## Planning

* Link Gcal
* User can log in and see their upcoming events
* User can log a time they arrived at a given event
* User can receive a recommendation as to when to leave

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Rails
* Rack::Throttle

_Token-Based Authentication from [this tutorial](https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api)._

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
