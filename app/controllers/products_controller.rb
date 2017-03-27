class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    Product.create(product_params)
    redirect_to products_path
  end

  def data
    if Product.find(params[:id])
      product = Product.find(params[:id])
      render json: ProductSerializer.serialize(product)
    else
      redirect_to product_path(product)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def inventory
    product = Product.find(params[:id])
    render plain: product.inventory > 0 ? true : false
  end

  def description
    product = Product.find(params[:id])
    render plain: product.description
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :inventory, :price)
  end
end
