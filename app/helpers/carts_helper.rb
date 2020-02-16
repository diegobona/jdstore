module CartsHelper

  # def get_total_price(cart)
  #   sum=0
  #   cart.cart_items.each do |cartItem|
  #     sum=sum+cartItem.product.price*cartItem.quantity
  #   end
  #   return sum
  #   # 或直接：sum，不要return，一样效果--会把最后一句的值返回
  # end

  def get_cart_total_price(cart)
    cart.sum_cart_total_price
  end

end
