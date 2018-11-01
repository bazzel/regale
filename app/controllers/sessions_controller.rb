class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by!(email: params[:email])
    # Here we set unique login token which is valid only for next 15 minutes
    user.update!(login_token: SecureRandom.urlsafe_base64,
                 login_token_valid_until: Time.now + 15.minutes)

    SessionsMailer.magic_link(user).deliver

    redirect_to root_path, notice: 'Login link sended to your email'
  end
end
