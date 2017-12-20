class AccountsController < ApplicationController
  skip_before_action :authorize_account

  def new
  end

  def authorize
    auth_command = CreateAuthClient.call
    if auth_command.success?
      auth_client = auth_command.result
      # client_secrets = Google::APIClient::ClientSecrets.load
      # auth_client = client_secrets.to_authorization
      auth_client.update!(
        :scope => 'https://www.googleapis.com/auth/calendar.readonly',
        :redirect_uri => 'http://localhost:3000/oauth_callback',
        :additional_parameters => {
          "access_type" => "offline",         # offline access
          "include_granted_scopes" => "true"  # incremental auth
        }
      )
      auth_uri = auth_client.authorization_uri.to_s
      redirect_to auth_uri
    else
      flash[:alert] = "Something went wrong with authorization!"
      redirect_to '/add_account'
    end
  end

  def oauth_callback
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.code = params[:code]
    auth_client.redirect_uri = 'http://localhost:3000/oauth_callback'
    auth_client.fetch_access_token!
    @account = Account.new(
      access_token: auth_client.access_token,
      id_token: auth_client.id_token,
      expires_in: auth_client.expires_in,
      refresh_token: auth_client.refresh_token,
      user_id: current_user.id
    )
    if @account.save
      session[:account_id] = @account.id
      flash[:notice] = 'Google calendar added successfully!'
      redirect_to '/calendar'
    else
      flash[:alert] = @account.errors.full_messages
      redirect_to '/add_account'
    end
  end
end
