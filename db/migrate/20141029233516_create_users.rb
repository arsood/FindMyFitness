class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.text :about_me
      t.string :username
      t.string :password
      t.string :user_type
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end