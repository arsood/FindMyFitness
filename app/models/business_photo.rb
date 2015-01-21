class BusinessPhoto < ActiveRecord::Base
	has_attached_file :business_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/temp/slide1.jpg"
  	validates_attachment_content_type :business_photo, :content_type => /\Aimage\/.*\Z/
end
