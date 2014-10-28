class CreateBusinessServices < ActiveRecord::Migration
  def change
    create_table :business_services do |t|
      t.integer :bus_id
      t.string :bus_service

      t.timestamps
    end
  end
end
