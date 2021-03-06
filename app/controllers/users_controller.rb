class UsersController < ApplicationController
  skip_before_action :authorize_user
  skip_before_action :authorize_account
  before_action :authorize_no_user

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to '/add_account'
    else
      flash[:alert] = user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
