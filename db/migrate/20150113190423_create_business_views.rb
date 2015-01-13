class CreateBusinessViews < ActiveRecord::Migration
  def change
    create_table :business_views do |t|
      t.integer :business_id

      t.timestamps
    end
  end
end
