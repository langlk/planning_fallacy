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

## TODO

* Clean up gcal code
* Set up log in with devise/bcrypt
* Make sure authentication works for repeated calls.
* Update redirect URLS and so on
* Figure out Cookie size issue

## Planning

* User flow:
  * Sign up
  * Link Gcal
  * See upcoming events
  * Checkin: list of events +/- 12 hours from now - select event, mark 'arrived', mark how many minutes ago
    * Store event name, time, amount late
  * Calculating: find avg lateness over all user events

* Models
  * Event:
    * Datetime occurred
    * Name
    * Lateness
    * User id

* User
  * Email
  * Password
  * Gcal: **If storing this in DB works, else keep it in session**
    * access_token
    * id_token
    * refresh_token
    * expires_in

* Link Gcal
* User can log in and see their upcoming events
* User can log a time they arrived at a given event
* User can receive a recommendation as to when to leave

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Rails

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
