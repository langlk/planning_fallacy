require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def calendar

    secrets = Google::APIClient::ClientSecrets.new({"web" => {"access_token" => current_user.token, "refresh_token" => current_user.refresh_token, "client_id" => ENV['GOOGLE_CLIENT_ID'], "client_secret" => ENV['GOOGLE_CLIENT_ID']}})
    cal = Google::Apis::CalendarV3::CalendarService.new
    cal.authorization = secrets.to_authorization
    cal.authorization.refresh!
    cal.list_calendar_lists
    @response = cal.list_events('primary',
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: (Time.now - 12.hour).iso8601,
                                   time_max: (Time.now + 12.hour).iso8601)
    binding.pry
  end
end
