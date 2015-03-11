class ReviewPhoto < ActiveRecord::Base
	has_attached_file :review_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/image-placeholder.jpg"
  	validates_attachment_content_type :review_photo, :content_type => /\Aimage\/.*\Z/
end
