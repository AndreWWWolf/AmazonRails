class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize!, only: [:edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      redirect_to @product
      # same as redirect_to product_path(@product)
    else
      # render will simply render the new.html.erb view in the views/products
      # directory. The #new action above will not be touched.
      render :new
    end
  end

  def index
    # @products = Product.all
    @products = Product.order(price: :DESC)
  end

  def show
    @review = Review.new
    # In this case only the product owner will have all reviews available in the
    # through @reviews (including hidden reviews).
    # You could also remove this logic here and do some logic in the view. Your use case (and
    # for now, the size of your Rails toolset) will determine the best way to things.
    # We've done it this way because with the tools available to us it minimizes the
    # amount of repeated code and if else statements in our view.
    if can? :crud, @product
      @reviews = @product.reviews.order(created_at: :desc)
    else
      @reviews = @product.reviews.where(hidden: false).order(created_at: :desc)
    end
  end

  def edit
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Product Deleted"
   @product.destroy
   redirect_to products_path

  end

  private

  def product_params
    # strong parameters are used primarily as a security practice to help
    # prevent accidentally allowing users to update sensitive model attributes.
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    @product = Product.find params[:id]
  end

  def authorize!
    redirect_to root_path, alert: "access denied" unless can? :crud, @product
  end
end
