class CreateReviewReplies < ActiveRecord::Migration
  def change
    create_table :review_replies do |t|
      t.integer :business_id
      t.integer :review_id
      t.text :reply_text

      t.timestamps
    end
  end
end
