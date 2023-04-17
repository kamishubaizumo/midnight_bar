class Tag < ApplicationRecord

  #　<%= "(#{tags.items.count})" %>を記述すると、エラーになる。上下入れ替えたら治った。

  has_many :item_tags, dependent: :destroy
  has_many :items, through: :item_tags

  

  validates :tag_name, presence: true

end
