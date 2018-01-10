class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :require_login, only: [:create], raise: false

  def create
    user = User.new(user_params)
    if user.save
      render json: { token: user.token }
    else
      render_unauthorized("Error registering user.")
    end
  end

  def show
    render json: {
      name: current_user.name,
      email: current_user.email,
      create_at: current_user.created_at,
      lateness: current_account.lateness
    }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
