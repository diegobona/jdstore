class OrdersController < ApplicationController

  def index
  end

  def show
    @order=Order.find_by_token(params[:id])
    @productLists=@order.product_lists
  end


  def create
    #点击“生成订单”按钮时，根据页面传来的数据新建一个order对象并存入数据库
    #注意页面上没传来的字段，要自己进行赋值
    @order=Order.new(order_params)
    @order.user=current_user
    @order.totalPrice=get_cart_total_price(get_current_cart)
    @order.save

    #新增订单成功后，建立该订单明细product_lists的缓存：
    # 思路一：数组方式
    # @productLists=[]
    # get_current_cart.cart_items.each do |c|
    #   @productList=ProductList.new
    #   @productList.quantity=c.quantity
    #   @productList.title=c.product.title
    #   @productList.price=c.product.price
    #   @productLists<<@productList
    # end
    # @order.product_lists=@productLists

    # 思路二：循环生成一个一个productList对象插入product_lists表(用save方法.一个对象对应一条表数据)：
    get_current_cart.cart_items.each do |c|
      #新建一个ProductList类对象
      @productList=ProductList.new
      #这一句老是想不起来!这一句就是指定新建的这个对象是哪个order的！！从has_many角度。另一个角度：product_lists表里有order_id字段啊。
      @productList.order=@order

      @productList.quantity=c.quantity
      @productList.title=c.product.title
      @productList.price=c.product.price
      #这个对象(这条数据)插入表中
      @productList.save
    end


    #订单创建成功后，清空购物车，并给用户发送一封邮件。deliver是安装的插件letter_opener的方法？
    get_current_cart.clearCartModel
    OrderMailer.notify_order_placed(@order).deliver!

    #跳转到该订单的show页面
    redirect_to order_path(@order.token)
    flash[:notice]="生成订单成功"
  end

  def pay_with_alipay
    @order=Order.find_by_token(params[:id])
    @order.pay_with("alipay")
    @order.make_payment!
    redirect_to order_path(@order.token),notice:"支付宝支付成功"

  end

  def pay_with_wechat
    @order=Order.find_by_token(params[:id])
    @order.pay_with("wechat")
    @order.make_payment!
    redirect_to order_path(@order.token),notice:"微信支付成功"
  end

  #用户申请取消订单
  def apply_to_cancel
    @order=Order.find_by_token(params[:id])
    #调用order_mailer.rb中方法，向管理员发送一封邮件
    OrderMailer.apply_cancel(@order).deliver!
    flash[:notice]="申请已提交"
    redirect_to :back
  end

  private
  def order_params
    params.require(:order).permit(:billing_name,:shipping_name,:shipping_address)
  end


end
