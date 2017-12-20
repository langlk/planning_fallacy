require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def calendar
    # client_secrets = Google::APIClient::ClientSecrets.load
    # auth_client = client_secrets.to_authorization
    # account = current_account
    # auth_client.access_token = account.access_token
    # auth_client.id_token = account.id_token
    # auth_client.expires_in = account.expires_in
    # auth_client.refresh_token = account.refresh_token
    # auth_client.refresh!
    auth_client = AuthRefreshAccess.call(current_account).result
    service = Google::Apis::CalendarV3::CalendarService.new
    calendar_id = 'primary'
    # Currently shows 12 hours before and 12 hours after
    @response = service.list_events(calendar_id,
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: (Time.now - 12.hour).iso8601,
                                   time_max: (Time.now + 12.hour).iso8601,
                                   options: { authorization: auth_client })
  end
end
