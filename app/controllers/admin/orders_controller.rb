class Admin::OrdersController < ApplicationController
  def index
    @orders=Order.order("id DESC")
  end

  def show
    @order=Order.find(params[:id])
    @product_lists=@order.product_lists
  end

  def ship
    @order=Order.find(params[:id])
    #调用order.rb中定义的状态机event，实现订单状态切换
    @order.ship!
    OrderMailer.notify_order_ship(@order).deliver!
    redirect_to :back
  end

  def shipped
    @order=Order.find(params[:id])
    #调用order.rb中定义的状态机event，实现订单状态切换
    @order.deliver!
    redirect_to :back
  end

  def cancel
    @order=Order.find(params[:id])
    #调用order.rb中定义的状态机event，实现订单状态切换
    @order.cancel_order!
    OrderMailer.notify_order_cancel(@order).deliver!
    redirect_to :back
  end

  def return
    @order=Order.find(params[:id])
    #调用order.rb中定义的状态机event，实现订单状态切换
    @order.return_good!
    redirect_to :back
  end




end
