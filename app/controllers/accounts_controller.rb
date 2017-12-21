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
    auth_command = AuthFetchAccessToken.call(params[:code])
    if auth_command.success?
      auth_client = auth_command.result
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
        flash[:alert] = ["Account could not be linked."]
        redirect_to '/add_account'
      end
    else
      flash[:alert] = ["Google authorization failed."]
      redirect_to '/add_account'
    end
  end
end
