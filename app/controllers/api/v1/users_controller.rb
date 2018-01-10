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

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
