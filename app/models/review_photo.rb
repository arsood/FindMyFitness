class ReviewPhoto < ActiveRecord::Base
	belongs_to :review

	has_attached_file :review_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/image-placeholder.jpg", :storage => :s3, :bucket => "findmyfitness"
  	validates_attachment_content_type :review_photo, :content_type => /\Aimage\/.*\Z/
end
