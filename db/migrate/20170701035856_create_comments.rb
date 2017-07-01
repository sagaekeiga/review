class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :name
      t.text :content
      t.text :product_id


      t.timestamps null: false
    end
  end
end
