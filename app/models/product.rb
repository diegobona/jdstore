class Product < ApplicationRecord
  validates :title,presence:true
  validates :price,presence:true
  validates :quantity,presence:true
  
  mount_uploader :product_img, ProductImgUploader
end
