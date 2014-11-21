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
      t.string :availability
      t.text :description
      t.integer :user_id
      t.float :lat
      t.float :lng
      t.integer :views, :default => 0

      t.timestamps
    end
  end
end
