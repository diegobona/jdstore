class Product < ApplicationRecord
  validates :title,presence:true
  validates :price,presence:true
  validates :quantity,presence:true

  has_many :cart_items
  has_many :carts,through: :cart_items,source: :cart

  mount_uploader :product_img, ProductImgUploader



end
