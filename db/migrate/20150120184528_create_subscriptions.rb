class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :plan_type
      t.string :subscription_status
      t.integer :customer_id
      t.string :customer_token
      t.integer :subscription_id

      t.timestamps
    end
  end
end
