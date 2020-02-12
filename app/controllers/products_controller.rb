class ProductsController < ApplicationController


  def index
    @products=Product.all
  end

  def show
    @product=Product.find(params[:id])
  end

  def add_to_cart
    @product=Product.find(params[:id])
    #current_cart是一个方法，调用它返回一个cart实例@current_cart。在ApplicationController中定义
    #然后由实例@current_cart调用Cart model中定义的add_product_to_cart方法
    get_current_cart.add_product_to_cart(@product)
    flash[:notice]="加入购物车成功"
    redirect_to :back
  end




end
