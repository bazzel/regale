class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  private

  def authenticate_user!
    if current_user.anonymous?
      redirect_to signin_path, alert: 'Not authenticated'
    end
  end
end
