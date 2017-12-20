class AccountsController < ApplicationController
  skip_before_action :authorize_account

  def new
  end

  def authorize
    auth_client = UpdateAuthClient.call.result
    auth_uri = auth_client.authorization_uri.to_s
    redirect_to auth_uri
  end

  def oauth_callback
    auth_client = AuthFetchAccessToken.call(params[:code]).result
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
