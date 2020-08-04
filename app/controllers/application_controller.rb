class ApplicationController < ActionController::Base
  before_action :current_time

  def current_time
    @time = Time.now.strftime('%Y-%m-%d %I:%M %p')
  end
end
