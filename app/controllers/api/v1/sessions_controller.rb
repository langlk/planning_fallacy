class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :require_login, only: [:create], raise: false

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      allow_token_to_be_used_only_once_for(user)
      render json: {
        name: user.name,
        email: user.email,
        token: user.token,
        created_at: user.created_at,
        has_account: user.account != nil,
        lateness: user.account ? user.account.lateness : nil
      }
    else
      render_unauthorized("Error with your login or password")
    end
  end

  def destroy
    logout
    head :ok
  end

  private

  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_token
  end

  def logout
    current_user.invalidate_token
  end
end
