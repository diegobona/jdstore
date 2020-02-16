class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items,source: :product

  def add_product_to_cart(product)
      cartitem=self.cart_items.build
      cartitem.product=product
      cartitem.quantity=1
      cartitem.save
  end

  def sum_cart_total_price
    sum=0
    self.cart_items.each do |cartItem|
      sum +=cartItem.product.price*cartItem.quantity
    end
    sum
  end

  def clearCartModel
    #不需要一个一个循环删除，直接all
    self.cart_items.destroy_all
  end

end
