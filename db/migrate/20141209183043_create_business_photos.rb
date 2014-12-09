class CreateBusinessPhotos < ActiveRecord::Migration
  def change
    create_table :business_photos do |t|
      t.integer :business_id
      t.integer :contributor_id

      t.timestamps
    end
  end
end
