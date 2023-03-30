class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :item_name, null: false
      t.text :item_text, null: false
      t.integer :no_tax_price, null: false
      t.integer :sale_status, null: false, default: 0
      t.integer :stock, null: false, default: 0


      t.timestamps
    end
  end
end
