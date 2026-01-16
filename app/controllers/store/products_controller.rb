class Store::ProductsController < Store::BaseController
  before_action :set_product, only: %i[ show edit update destroy ]

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to store_product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if current_user.can_edit_product?(@product) && @product.update(product_params)
      redirect_to store_product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.can_delete_product?(@product)
      @product.destroy
      redirect_to store_products_path
    else
      redirect_to @product, alert: "You are not allowed to delete this product."
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
  def authorize_user
    unless current_user.can_create_product?
      redirect_to root_path, alert: "You are not allow to access this page."
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :featured_image, :price_in_cents, :comments)
  end

end
