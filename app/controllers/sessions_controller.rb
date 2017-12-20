class SessionsController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_account

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:account_id] = user.account.id
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to '/'
    else
      flash[:alert] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:account_id] = nil
    flash[:notice] = "You've signed out!"
    redirect_to '/signin'
  end
end
