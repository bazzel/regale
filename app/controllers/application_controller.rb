class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  before_action :make_action_mailer_use_request_host_and_protocol
  helper_method :current_user

  def current_user=(user)
    session[:user_id] = user.id
  end

  # If i don't find a user from session i return null object
  def current_user
    User.find_by(id: session[:user_id]) || NullUser.new
  end

  private

  def authenticate_user!
    if current_user.anonymous?
      redirect_to signin_path, alert: 'Not authenticated'
    end
  end

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
