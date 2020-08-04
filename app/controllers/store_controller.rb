class StoreController < ApplicationController
  def index
    @v_counter = v_counter
    @products = Product.order(:title)
  end

  private
  def v_counter
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end

    session[:counter]
  end
end
