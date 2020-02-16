class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def reduceProduct
    self.product.quantity=self.product.quantity-self.quantity
  end
end
