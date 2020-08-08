class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :current_time

  private
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
  def current_time
    @time = Time.now.strftime('%Y-%m-%d %I:%M %p')
  end
end
