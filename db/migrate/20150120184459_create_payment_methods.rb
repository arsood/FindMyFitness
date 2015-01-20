class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :payment_token
      t.string :customer_id
      t.integer :user_id

      t.timestamps
    end
  end
end
