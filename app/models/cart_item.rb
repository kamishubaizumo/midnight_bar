class CartItem < ApplicationRecord

  belongs_to :item
  belongs_to :customer

  validates :item_id, :item_quantity, presence: true

       #小計金額
       def small_total_price
        (item.on_tax_price * item_quantity).floor
      end


end
