class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
    if @user
      sign_in @user
      redirect_to root_path
    else
      flash[:alert] = 'Access Denied.'
      redirect_to new_user_session_path
    end
  end
end
