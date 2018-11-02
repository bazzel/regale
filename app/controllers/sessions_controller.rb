class SessionsController < ApplicationController
  def create
    @email = params[:email]
    user = User.find_or_create_by!(email: @email)
    user.update!(login_token: SecureRandom.urlsafe_base64,
                 login_token_valid_until: 30.minutes.from_now)

    SessionsMailer.magic_link(user).deliver
  end
end
