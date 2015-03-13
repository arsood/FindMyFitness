class CreateBusinessOwners < ActiveRecord::Migration
  def change
    create_table :business_owners do |t|
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
