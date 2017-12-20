class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_account

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_account
    @current_account ||= Account.find(session[:account_id]) if session[:account_id]
  end
end
