class MailToController < ApplicationController

  def menu_choices
    @event = authorize(Event.find(params[:event_id]), policy_class: MailToPolicy).decorate
    @guests = @event.guests

    mailer = MailToMailer.with(event: @event, guests: @guests).menu_choices
    redirect_to mailer.mailto and return
  end

end
