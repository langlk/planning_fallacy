require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class SiteController < ApplicationController
  def home
  end

  def calendar_auth
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/calendar.readonly',
      :redirect_uri => 'http://localhost:3000/users/auth/google_oauth2',
      :additional_parameters => {
        "access_type" => "offline",         # offline access
        "include_granted_scopes" => "true"  # incremental auth
      }
    )
    auth_uri = auth_client.authorization_uri.to_s
    redirect_to auth_uri
  end

  def calendar_open
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.code = params[:code]
    auth_client.redirect_uri = 'http://localhost:3000/users/auth/google_oauth2'
    auth_client.fetch_access_token!
    session[:access_token] = auth_client.access_token
    session[:id_token] = auth_client.id_token
    session[:expires_in] = auth_client.expires_in
    session[:refresh_token] ||= auth_client.refresh_token
    redirect_to '/calendar'
  end

  def calendar
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    account = current_account
    auth_client.access_token = account.access_token
    auth_client.id_token = account.id_token
    auth_client.expires_in = account.expires_in
    auth_client.refresh_token = account.refresh_token
    auth_client.refresh!
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
