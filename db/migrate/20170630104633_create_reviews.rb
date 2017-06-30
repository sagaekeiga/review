class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.date :date
      t.bigint :tweet_id
      t.text :product
      t.text :name
      t.text :text
      t.text :url


      t.timestamps null: false
    end
  end
end
