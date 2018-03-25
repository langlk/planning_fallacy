class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :require_login, only: [:create], raise: false

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        name: user.name,
        email: user.email,
        token: user.token,
        created_at: user.created_at,
        has_account: user.account != nil,
        lateness: user.account ? user.account.lateness : nil
      }
    else
      render_unauthorized("Error registering user.")
    end
  end

  def show
    render json: {
      name: current_user.name,
      email: current_user.email,
      token: current_user.token,
      created_at: current_user.created_at,
      has_account: current_account != nil,
      lateness: current_account ? current_account.lateness : nil
    }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
