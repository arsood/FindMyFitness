class CreateBusinessPhotos < ActiveRecord::Migration
  def change
    create_table :business_photos do |t|
      t.string :business_hash
      t.integer :contributor_id

      t.timestamps
    end
  end
end
