class Api::V1::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize_user
  skip_before_action :authorize_account

  before_action :require_login

  def require_login
    authenticate_token || render_unauthorized("Access denied")
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def current_account
    if current_user
      current_user.account
    end
  end

  protected

  def render_unauthorized(message)
    errors = { errors: [ { detail: message } ] }
    render json: errors, status: :unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      if user = User.find_by_token(token)
        ActiveSupport::SecurityUtils.secure_compare(
                        ::Digest::SHA256.hexdigest(token),
                        ::Digest::SHA256.hexdigest(user.token))
        user
      end
    end
  end
end
