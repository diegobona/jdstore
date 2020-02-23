class Account::OrdersController < ApplicationController
  def index
    #不要思维定势这样写！现在是要当前用户的order
    # @orders=Order.all
    @orders=current_user.orders.order("id DESC")
  end
end
