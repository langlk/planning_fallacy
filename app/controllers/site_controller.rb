require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def profile
  end

  def calendar
    # If integration testing, use set time so vcr handls request.
    if Rails.env.test?
      events_command = GetCalendarEvents.call(current_account, "2017-12-21T11:42:50-08:00", "2017-12-22T11:42:50-08:00")
    else
      events_command = GetCalendarEvents.call(current_account, 0, 24)
    end
    if events_command.success?
      @events = events_command.result.items
    else
      @events = []
      flash[:alert] = "There was a problem fetching your events."
    end
  end
end
