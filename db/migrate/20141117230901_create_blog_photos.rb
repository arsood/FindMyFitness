class CreateBlogPhotos < ActiveRecord::Migration
  def change
    create_table :blog_photos do |t|
      t.string :post_id
      t.integer :contributor_id

      t.timestamps
    end
  end
end
