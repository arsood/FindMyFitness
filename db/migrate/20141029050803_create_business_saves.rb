class CreateBusinessSaves < ActiveRecord::Migration
  def change
    create_table :business_saves do |t|
      t.integer :user_id
      t.integer :business_id

      t.timestamps
    end
  end
end
