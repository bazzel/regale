class WelcomeController < ApplicationController
  def show
    @my_upcoming_guests = Guest
      .upcoming
      .for_user(current_user)
      .page(params[:page]).per(1)
      .includes(:event)
      .decorate
  end
end
