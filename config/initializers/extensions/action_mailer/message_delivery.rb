module MailTo
  include ActionView::Helpers::UrlHelper
  REGEX = %r{.*\shref="(?<href>.*)".*}

  def mailto
    link = mail_to(nil, 'Lorem', subject: subject, body: text_part.body.encoded)
    matches = link.match(REGEX)
    matches[:href].gsub('&amp;', '&')
  end
end

ActionMailer::MessageDelivery.include(MailTo)
