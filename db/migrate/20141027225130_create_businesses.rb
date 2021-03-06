class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :business_type
      t.string :business_hash
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone
      t.string :website
      t.string :availability
      t.string :account_type, default: "unpaid"
      t.text :description
      t.integer :user_id
      t.float :lat
      t.float :lng
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
