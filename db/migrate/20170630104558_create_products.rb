class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.text :category
      t.text :switch
      t.integer :rank, null: false, default: 0
      t.text :url

      t.timestamps null: false
    end
  end
end
