class CreateBlogFollowers < ActiveRecord::Migration
  def change
    create_table :blog_followers do |t|
      t.integer :owner_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
