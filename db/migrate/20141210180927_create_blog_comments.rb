class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :blog_id
      t.integer :commentor_id
      t.text :blog_comment

      t.timestamps
    end
  end
end
