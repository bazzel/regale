class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def show
    @my_upcoming_guests = Guest
      .upcoming
      .for_user(current_user)
      .page(params[:page]).per(1)
      .includes(:event)
  end

  private

  def authenticate_user!
    if current_user.anonymous?
      redirect_to signin_path, alert: 'Not authenticated'
    end
  end
end
