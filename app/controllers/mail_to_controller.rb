class MailToController < ApplicationController

  def menu_choices
    @event = authorize(Event.find(params[:event_id]), policy_class: MailToPolicy)
    @guests = @event.guests.includes(:soup, :appetizer, :main_course, :dessert)
    @event = @event.decorate

    mailer = MailToMailer.with(event: @event, guests: @guests).menu_choices
    redirect_to mailer.mailto and return
  end

end
