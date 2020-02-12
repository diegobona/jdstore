class CartsController < ApplicationController

  #不需要？view中直接通过helper方法get_current_cart可获取
  def show
    @cart=Cart.find(params[:id])
  end

end
