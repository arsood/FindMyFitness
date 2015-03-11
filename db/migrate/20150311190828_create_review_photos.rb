class CreateReviewPhotos < ActiveRecord::Migration
  def change
    create_table :review_photos do |t|
      t.string :review_hash
      t.integer :contributor_id

      t.timestamps
    end
  end
end
