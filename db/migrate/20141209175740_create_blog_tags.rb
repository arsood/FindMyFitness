class CreateBlogTags < ActiveRecord::Migration
  def change
    create_table :blog_tags do |t|
      t.integer :blog_id
      t.string :blog_tag

      t.timestamps
    end
  end
end
