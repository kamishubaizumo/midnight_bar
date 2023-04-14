class Item < ApplicationRecord

  has_one_attached :image

  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  validates :item,:text,:no_tax_price,:stock,:sale_status, presence: true
  

  # 画像を取り扱う
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-images.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
end

  # 消費税込みの値段
  def on_tax_price
    tax_rate = 1.1
  (self.no_tax_price * tax_rate).floor
    
  end


end
