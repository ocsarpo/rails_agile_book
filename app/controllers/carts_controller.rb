class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    # @cart = Cart.new(cart_params)
    @cart = current_cart

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      begin
        @cart = Cart.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        logger.error "잘못된 카트 id에 접근시도 #{params[:id]}"
        redirect_to store_url, notice: 'Invalid cart'
      else
        respond_to do |format|
          format.html # show.html.erb / edit...
          format.json { render json: @cart }
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end
end
