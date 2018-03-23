class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :current_account
  before_action :authorize_user
  before_action :authorize_account

  def current_user
    print params
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif params[:token]
      @current_user ||= authenticate_token(params[:token])
      session[:user_id] = @current_user.id
      @current_user
    end
  end

  def current_account
    if session[:account_id]
      @current_account ||= Account.find(session[:account_id])
    else
      current_user.account if current_user
    end
  end

  def authorize_user
    redirect_to '/signin' unless current_user
  end

  def authorize_account
    redirect_to '/add_account' unless current_account
  end

  def authorize_no_user
    redirect_to root_path unless !current_user
  end

  def authorize_no_account
    redirect_to root_path unless !current_account
  end

  private

  def authenticate_token(token)
    if user = User.find_by_token(token)
      ActiveSupport::SecurityUtils.secure_compare(
                      ::Digest::SHA256.hexdigest(token),
                      ::Digest::SHA256.hexdigest(user.token))
      user
    end
  end
end
