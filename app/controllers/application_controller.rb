class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :get_current_cart

  def get_current_cart
    #如果为空，则调用find_cart方法
    @current_cart=@current_cart || find_cart
  end

  def find_cart
    #读取存在session中的card_id，通过其找到对应的cart实例
    cart=Cart.find_by(id:session[:card_id])
    #如果空，则新建一个cart实例给当前用户
    if cart.blank?
      cart=Cart.create
      session[:card_id]=cart.id
    end
    #返回该cart实例作为@current_cart
    return cart
  end

end
