class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:edit,:update,:destroy]
  
  def index
    @products=Product.all
  end
  
  def show
    @product=Product.find(params[:id])
  end
  
  def new
    @product=Product.new
  end
  def create
    @product=Product.new(product_params)
    @product.save
    redirect_to admin_products_path
  end
  
  def edit
    @product=Product.find(params[:id])
  end
  def update
    @product=Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_products_path
  end
  
  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end
  
  
  def product_params
    params.require(:product).permit(:title,:description,:price,:quantity)
  end
end
