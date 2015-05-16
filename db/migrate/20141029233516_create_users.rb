class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.text :about_me
      t.string :password
      t.string :password_digest
      t.string :user_type, default: "standard"
      t.string :city
      t.string :state
      t.string :auth_id
      t.string :fb_img
      t.string :reset_token

      t.timestamps
    end
  end
end
