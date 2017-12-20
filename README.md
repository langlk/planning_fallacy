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

* X Set up actual calculation/recommendation
* Styling
* Authorization: try to prevent people from re-approving access and possibly LOSING REFRESH KEY FOREVER
* TESTSTESTSTESTSTESTS
* Error handling because you know that API client is gonna throw a fit
* User > Account > Checkin destroy properly
* X Events returns empty and everything breaks

## Planning

* User flow:
  * X Sign up
  * X Link Gcal
  * X See upcoming events
  * X Checkin: list of events +/- 12 hours from now - select event, mark 'arrived',
    * **TODO:** mark how many minutes ago
    * Store event name, time, amount late
  * X Calculating: find avg lateness over all user events

* Models
  * X Checkin:
    * Datetime occurred
    * Name of event
    * Lateness
    * User id

  * X User
    * Email
    * Password
    * Username
  * X Account
    * user_id
    * access_token
    * id_token
    * refresh_token
    * expires_in

* X Link Gcal
* X User can log in and see their upcoming events
* X User can checkin when they arrive at a given event
* **ToDo** User can receive a recommendation as to when to leave

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Rails

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
