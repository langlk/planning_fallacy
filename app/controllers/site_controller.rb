require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def profile
  end

  def calendar
    events_command = GetCalendarEvents.call(current_account)
    if events_command.success?
      @events = events_command.result.items
    else
      @events = []
      flash[:alert] = "There was a problem fetching your events."
    end
  end
end
