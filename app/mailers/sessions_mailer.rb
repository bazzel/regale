class SessionsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sessions_mailer.magic_link.subject
  #
  def magic_link(user)
    @user = user
    @magic_link = token_sign_in_url(user.login_token)

    mail to: user.email, subject: 'Welcome'
  end
end
