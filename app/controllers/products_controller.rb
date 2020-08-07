class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.order(:title)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
        # 상품이 갱신될 때 마다 전체 카탈로그를 브로드캐스트함
        @products = Product.all.order(:title)
        # 전체 페이지가 아닌 store/index 만 스트링으로 전송함
        # 브로드캐스트 메시지는 루비 해시로 구성되며 JSON으로 변환되어 js로 해석함
        # 아래의 경우 html이 hash key임
        ActionCable.server.broadcast 'products', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # for atom_feed
  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    # stale? -> 객체가 수정되어서 HTTP 리소스가 갱신될 필요가 있는지 검사함
    # https://blog.bigbinary.com/2016/08/16/rails-5-supports-passing-collection-of-records-to-fresh_when-and-stale.html
    #
    # atom feed
    # https://m.blog.naver.com/PostView.nhn?blogId=estern&logNo=110145610169&proxyReferer=https:%2F%2Fwww.google.com%2F
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price)
    end
end
