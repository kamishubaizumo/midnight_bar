class Item < ApplicationRecord

  has_one_attached :image

  validates :item, presence: true
  validates :text, presence: true

end
