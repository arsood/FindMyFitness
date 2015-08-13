class User < ActiveRecord::Base
	has_secure_password

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "profile-placeholder.png", :storage => :s3, :bucket => "findmyfitness"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	validates :email_address, uniqueness: true
end