class CreateBlogLikes < ActiveRecord::Migration
  def change
    create_table :blog_likes do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
