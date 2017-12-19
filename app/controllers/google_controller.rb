require 'signet/oauth_2/client'
require 'google/apis/calendar_v3'

class GoogleController < ApplicationController
  skip_before_action :verify_authenticity_token
  def signin
    response = RestClient::Request.execute(
      method: :get,
      url: "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=" + params[:idtoken],
    )
    results = JSON.parse(response)
    if results['aud'] == ENV['GOOGLE_CLIENT_ID']
      render json: { message: "user ok" }, status: :success
    else
      render json: { error: "user not ok" }, status: :unauthorized
    end
  end

  def authorize
    client = Signet::OAuth2::Client.new(
      :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
      :token_credential_uri =>  'https://accounts.google.com/o/oauth2/token',
      :client_id => '85551620160-m9i5am2njoqv2nt34q7n6mrcjijftaer.apps.googleusercontent.com',
      :client_secret => ENV['GOOGLE_CLIENT_SECRET'],
      :scope => 'https://www.googleapis.com/auth/calendar.readonly',
      :redirect_uri => 'http://localhost:3000'
    )
    client.code = params[:code]
    response = client.fetch_access_token!
    binding.pry
    cal = Google::Apis::CalendarV3::CalendarService.new
    cal.authorization = client
    @response = cal.list_events('primary',
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: (Time.now - 12.hour).iso8601,
                                   time_max: (Time.now + 12.hour).iso8601)
    binding.pry
  end

  def oauth
  end
end
