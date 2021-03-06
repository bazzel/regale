class MailToController < ApplicationController

  def menu_choices
    @event = authorize(Event.find(params[:event_id]), policy_class: MailToPolicy)
    @guests = @event.guests.includes(:soup, :appetizer, :main_course, :dessert).where(accept_status: sanizited_accept_status_param)
    @event = @event.decorate

    mailer = MailToMailer.with(event: @event, guests: @guests).menu_choices
    redirect_to mailer.mailto and return
  end

  private
  def sanizited_accept_status_param
    accept_status_param_with_default.map { |status| status.blank? ? nil : status }
  end

  def accept_status_param_with_default
    params[:accept_status] || []
  end
end
