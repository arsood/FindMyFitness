class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_type
      t.integer :item_id
      t.integer :guest_user_id
      t.integer :owner_user_id
      t.boolean :dismissed, default: false

      t.timestamps
    end
  end
end
