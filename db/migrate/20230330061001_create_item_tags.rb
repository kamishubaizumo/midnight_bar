class CreateItemTags < ActiveRecord::Migration[6.1]
  def change
    create_table :item_tags do |t|

      t.integer :item_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    #ひとつのアイテムに同じタグを登録できない
    add_index :item_tags, [:item_id, :tag_id], unique: true
  end
end
