class CartsController < ApplicationController

  #不需要？view中直接通过helper中get_current_cart可获取然后展示
  def show
    @cart=Cart.find(params[:id])
  end

  def clearCart
    @cart=get_current_cart
    @cart.clearCartModel
    redirect_to :back
  end

end
