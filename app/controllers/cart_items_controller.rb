class CartItemsController < ApplicationController
  def destroy
    @cart=Cart.find(params[:cart_id])
    @cart_item=@cart.cart_items.find(params[:id])
    @cart_item.destroy
    flash[:notice]="删除成功"
    redirect_to :back

  end

end
