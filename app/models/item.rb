class Item < ApplicationRecord

  has_one_attached :image

  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  validates :item_name,:item_text,:no_tax_price,:stock,:sale_status, presence: true
  

  # 画像を取り扱う。
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-images.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 編集するとき、タグの入れ替えをする。
  def save_tag(sent_tags)
    unless sent_tags.empty?
      self.item_tags.destroy_all

      sent_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(tag_name: new)

        unless self.tags.include?(new_post_tag)
          #include? => アイテムにすでに同じタグが関連付けられているかどうかをチェックし、
          #それがない場合にのみ、新しいタグをアイテムに関連付けする
          
          self.tags << new_post_tag
           #<<演算子 新しいタグがアイテムに関連付けられ、データベースに保存される。
        end
      end
    end
  end

  # 消費税込みの値段
  def on_tax_price
    tax_rate = 1.1
  (self.no_tax_price * tax_rate).floor
  end


end
