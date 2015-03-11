class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :business_id
      t.integer :star_rating
      t.text :review_text
      t.string :review_hash

      t.timestamps
    end
  end
end
