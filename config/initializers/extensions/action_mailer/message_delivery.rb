module MailTo
  include ActionView::Helpers::UrlHelper
  require 'htmlentities'

  REGEX = %r{.*\shref="(?<href>.*)".*}

  def mailto
    link = mail_to(nil, 'Lorem', subject: subject, body: mail_to_body)
    matches = link.match(REGEX)

    matches[:href].gsub('&amp;', '&')
  end

  private
  def mail_to_body
    coder = HTMLEntities.new
    coder.decode(text_part.body.encoded)
  end
end

ActionMailer::MessageDelivery.include(MailTo)
