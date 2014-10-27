class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :business_type
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :phone
      t.string :website
      t.string :monday_start
      t.string :monday_end
      t.string :tuesday_start
      t.string :tuesday_end
      t.string :wednesday_start
      t.string :wednesday_end
      t.string :thursday_start
      t.string :thursday_end
      t.string :friday_start
      t.string :friday_end
      t.string :saturday_start
      t.string :saturday_end
      t.string :sunday_start
      t.string :sunday_end
      t.text :description
      t.integer :views

      t.timestamps
    end
  end
end
