class MailToMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_to_mailer.menu_choices.subject
  #
  def menu_choices
    @event = params[:event]
    @guests = params[:guests]

    mail
  end
end
