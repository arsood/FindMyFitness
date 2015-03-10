class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.text :event_description
      t.string :event_category
      t.string :event_location
      t.datetime :event_date
      t.string :event_time
      t.string :event_id
      t.integer :business_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
