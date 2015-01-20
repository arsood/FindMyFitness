class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :plan_type
      t.string :subscription_status

      t.timestamps
    end
  end
end
