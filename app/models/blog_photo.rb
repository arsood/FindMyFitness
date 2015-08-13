class BlogPhoto < ActiveRecord::Base
	has_attached_file :post_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "temp/slide1.jpg", :storage => :s3, :bucket => "findmyfitness"
  	validates_attachment_content_type :post_photo, :content_type => /\Aimage\/.*\Z/
end
