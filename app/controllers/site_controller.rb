require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def calendar
    @events = GetCalendarEvents.call(current_account).result.items
  end
end
