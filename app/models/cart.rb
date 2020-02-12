class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items,source: :product

  def add_product_to_cart(product)
    #判断当前购物车里是否已有该商品
    #self表示当前cart实例
    # if !self.cart_items
    #   self.cart_items.each do |cart_item|
    #     if cart_item.product == product
    #       cartitem.quantity++
    #   end
    # else
      cartitem=self.cart_items.build
      cartitem.product=product
      cartitem.quantity=1
      cartitem.save
    # end

  end

end
