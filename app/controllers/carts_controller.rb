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

  def checkout
    #进入checkout页面，就预生成一个order对象，不存入数据库。后面点了“生成订单”才用“create”action写入库！
    @order=Order.new
  end

end
