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
end
