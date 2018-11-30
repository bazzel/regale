class WelcomeController < ApplicationController
  skip_after_action :verify_authorized

  def show
    @my_upcoming_guests = policy_scope(Guest)
      .upcoming
      .page(params[:page]).per(1)
      .includes(:event)
      .order('events.scheduled_at')
      .decorate
  end
end
