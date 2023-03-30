class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|

      t.string :tag_name, null: false

      t.timestamps
    end
    #同じ文字列のタグを登録させない
    add_index :tags,:tag_name, unique: true
  end
end
