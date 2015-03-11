class CreateBusinessServices < ActiveRecord::Migration
  def change
    create_table :business_services do |t|
      t.integer :business_id
      t.string :bus_service

      t.timestamps
    end
  end
end
