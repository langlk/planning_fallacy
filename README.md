# Planning Fallacy

### _Epicodus Project in Ruby on Rails, December 21, 2017_

### By Kelsey Langlois

## Description

_This is an app to help people compensate for the Planning Fallacy. It uses a user's Google Calendar to gather their events, and allows them to see upcoming events and check in when they arrive at a given event. The data from these checkins is used to track how late, on average, a user is to events._

## Installation and Setup

This app is deployed to Heroku at [planningfallacy.herokuapp.com](https://planningfallacy.herokuapp.com) To install on your own machine, follow the instructions below:

* Clone this repository.
* You will need to set up a Google APIs project:
  * Visit the [Google APIs Dashboard](https://console.cloud.google.com/apis/dashboard)
  * Create a new project.
  * Under the credentials tab, select "Create Credentials" > "OAuth client ID"
  * Select "Web application"
  * Add `http://localhost:3000/oauth_callback` to the "Authorized redirect URIs" list
  * Create the credentials, then from the dashboard click the download link
  * Convert the downloaded JSON to a JSON string. (`JSON.dump` will accomplish this)
  * Save this JSON string to an ENV variable `GOOGLE_CLIENT_SECRETS`
  * Save a second ENV variable `GOOGLE_REDIRECT_URI="http://localhost:3000/oauth_callback"`
* Run the following commands in the project root directory:
  ```
  bundle update
  rake db:setup
  rails s
  ```
* Open ```localhost:3000``` in your web browser

## TODO:
  * Events can only be checked into once.
  * Get Upcoming Calendar events:
    * _Needs param for whether to get checkin scoped or calendar scoped._
    * _REMOVE EXTRA CALENDAR INFO FROM RESPONSE_
  * Clearer errors/responses.

## Specifications

* New User Registration Flow:
  * User registers with name, email, and password.
  * User is directed to the "Add Google Calendar" page.
  * Clicking the "Authorize" button will redirect user to the Google OAuth consent page.
  * Once a user provides the app with Calendar Read permissions, they are redirected to the app.
  * The app saves a user's refresh and access tokens, and can now access their calendar.
  * The user can now use the calendar, checkin, and profile sections of the app.
* Calendar
  * The calendar page displays events on a user's primary GCal taking place in the next 24 hours.
* Checkins
  * The checkin page displays events taking place from 3 hours previous to 12 hours in the future.
  * Users can choose an event to check in at, and the app will calculate their lateness based on the current time.
* Profile
  * On the profile page, users can see:
    * Their basic info: name, email, and date joined.
    * Their statistics: average lateness (based on all checkins) and number of checkins.

### API
API V1 currently uses the built in `has_secure_token` method to generate a token for a user's access to the API, based on [this tutorial](https://rubyplus.com/articles/4311-Securing-an-API-in-Rails-5-using-Token-Based-Authentication). This is not exactly a viable production security strategy.
#### Endpoints
* ```POST /api/v1/signup```
  * **Params:**
    * ```name``` - user name, ```string```, _Required_
    * ```email``` - user email address, ```string```, _Required_
    * ```password``` - user password, ```string```, _Required_
    * ```password_confirmation``` - user password confirmation, ```string```, _Required_
  * Creates user account and returns user's access token if successful. Otherwise returns an error.
* ```POST /api/v1/signin```
  * **Params:**
    * ```email``` - user email address, ```string```, _Required_
    * ```password``` - user password, ```string```, _Required_
  * Returns a new token for user account access if email and password are valid. Otherwise returns an error.
* ```DELETE /api/v1/signout```
  * **Headers:**
    * ```Authorization``` - user token in format: "Token [user_token]", _Required_
  * Logs user out, deleting current access token and returning 200 if successful.
* ```GET /api/v1/events```
  * **Headers:**
    * ```Authorization``` - user token in format: "Token [user_token]", _Required_
  * If authorized, returns a list of user's events.
* ```GET /api/v1/user```
  * **Headers:**
    * ```Authorization``` - user token in format: "Token [user_token]", _Required_
  * If authorized, returns following info for user: name, email, created_at, and lateness.
* ```POST /api/v1/checkins```
  * **Headers:**
    * ```Authorization``` - user token in format: "Token [user_token]", _Required_
  * **Params:**
    * ```event_id``` - GCal id of event to checkin to, ```string```, _Required_
  * If user is authorized and event id is valid, creates a new checkin for the user for that event.

## Known Bugs

* Users can check in to events multiple times.

* If a user cancels access permissions to their Google Calendar, there is not currently a way to approve these permissions again. At present time, deleting the old Account record (**not** the User record) is the best fix to allow them to re-approve access.

## Planned Functionality

* Using location services to verify user is at event.
* Integrating Google Maps directions to provide suggested times for a user to leave for an event.
* Allowing users to re-approve access to their Google Calendar.
* Preventing multiple checkins to one event.

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Rails
* Google Calendar API ([Ruby Client](https://github.com/google/google-api-ruby-client))
* [Semantic UI](https://github.com/doabit/semantic-ui-sass)
* [SimpleCommand](https://github.com/nebulab/simple_command)

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
