class CartItemsController < ApplicationController

  def destroy
    @cart=get_current_cart
    #路由/carts/:cart_id/cart_items/:id里的:id 设计为product_id，它也能唯一定位一个cart_item
    @cart_item=@cart.cart_items.find_by(product_id:params[:id])
    @product=@cart_item.product
    @cart_item.destroy
    flash[:notice]="删除成功"
    redirect_to :back
  end

  def update
    @cart=get_current_cart
    #路由/carts/:cart_id/cart_items/:id里的:id 设计为product_id，它也能唯一定位一个cart_item
    @cart_item=@cart.cart_items.find_by(product_id:params[:id])
    @product=@cart_item.product
    #只有该商品剩余数量>=购物车里用户填的数量，才允许添加。cartItemParams就是最下面定义的白名单参数,就一个quantity。to_i是转成integer
    if @product.quantity>=cartItemParams[:quantity].to_i
      #把用户在页面填的quantity值更新到数据库中cart_items表的quantity字段
      @cart_item.update(cartItemParams)
      #为何教程里不需要这句？而且这句不生效、数据库里值没变？
      @product.quantity=@product.quantity-@cart_item.quantity
      redirect_to cart_path(@cart)
      flash[:notice]="更新商品数量成功"
    else
      redirect_to cart_path(@cart)
      flash[:warning]="商品数量不足"
    end
  end

  private
  def cartItemParams
    params.require(:cart_item).permit(:quantity)
  end



end
