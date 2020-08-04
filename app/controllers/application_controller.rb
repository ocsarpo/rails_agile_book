class ApplicationController < ActionController::Base
  before_action :current_time

  def current_time
    @time = Time.now.strftime('%Y-%m-%d %I:%M %p')
  end

  private
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
