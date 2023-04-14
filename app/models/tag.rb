class Tag < ApplicationRecord

  has_many :items, through: :item_tags
  has_many :item_tags, dependent: :destroy

  validates :tag_name, presence: true

end
