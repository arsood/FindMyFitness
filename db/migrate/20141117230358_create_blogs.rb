class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.string :post_id
      t.text :post_text
      t.string :post_title
      t.string :post_privacy, default: "public"

      t.timestamps
    end
  end
end
