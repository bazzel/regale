class ApplicationMailer < ActionMailer::Base
  default from: "#{Rails.application.config.app_name} <no-reply@kabisa.nl>"
  layout 'mailer'
end
