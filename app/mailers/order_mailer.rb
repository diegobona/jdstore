class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    # notify_order_placed.html.erb中要取这里的@order和@product_lists
    @order=order
    @user=@order.user
    @product_lists=@order.product_lists
    mail(to: @user.email, subject:"JDstore感谢您完成本次下单，以下是您本次购物明细#{@order.token}")
  end

  #用户申请取消订单时，自动发邮件给管理员
  def apply_cancel(order)
    # apply_cancel.html.erb中要取这里的@order和@product_lists
    @order=order
    @user=@order.user
    @product_lists=@order.product_lists
    mail(to: "service@jdstore.com",subject:"用户申请取消订单#{@order.token}")
  end

  #管理员在后台对订单进行出货后，给用户发送邮件
  def notify_order_ship(order)
    # notify_order_ship.html.erb中要取这里的@order和@product_lists
    @order=order
    @user=@order.user
    @product_lists=@order.product_lists
    mail(to: @user.email,subject:"JDstore您的订单#{@order.token}正在出货中")
  end

  #管理员在后台对订单进行取消后，给用户发送邮件
  def notify_order_cancel(order)
    # notify_order_cancel.html.erb中要取这里的@order和@product_lists
    @order=order
    @user=@order.user
    @product_lists=@order.product_lists
    mail(to:@user.email,subject:"JDstore您的订单#{@order.token}已取消")
  end

end
