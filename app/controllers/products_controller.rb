class ProductsController < ApplicationController


  def index
    @products=Product.all
  end

  def show
    @product=Product.find(params[:id])
  end

  def add_to_cart
    @product=Product.find(params[:id])
    #get_current_cart是一个helper方法，它返回一个cart实例@current_cart。在ApplicationController中定义.
    #然后由实例@current_cart调用Cart model中定义的add_product_to_cart方法
    @current_cart=get_current_cart

    ########已加入购物车的不允许再加入##########
    #不用这样麻烦！不一定要一层层往下：cart->cartitems->product！——
    # @is_added=false
    # @current_cart.cart_items.each do |cart_item|
    #   if cart_item.product==@product
    #     @is_added=true
    #     flash[:warning]="此商品已在购物车"
    #     redirect_to :back
    #     break
    #   end
    # end
    # if @is_added==false
    #   @current_cart.add_product_to_cart(@product)
    #   flash[:notice]="加入购物车成功"
    #   redirect_to :back
    # end
    #这样写才合理——
    if @current_cart.products.include?(@product)
     flash[:warning]="#{@product.title}已在购物车"
     redirect_to :back
    else
      @current_cart.add_product_to_cart(@product)
      flash[:notice]="加入#{@product.title}到购物车成功"
      redirect_to :back
    end



  end




end
