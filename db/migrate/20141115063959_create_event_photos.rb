class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|
      t.string :event_id
      t.integer :contributor_id

      t.timestamps
    end
  end
end
