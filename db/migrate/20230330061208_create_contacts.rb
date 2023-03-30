class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.integer :customer_id
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :title, null: false
      t.text :messege, null: false
      t.boolean :contact_status, null: false, default: false

      t.timestamps
    end
  end
end
