class EventPhoto < ActiveRecord::Base
	has_attached_file :event_photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/image-placeholder.jpg", :storage => :s3, :bucket => "findmyfitness"
  	validates_attachment_content_type :event_photo, :content_type => /\Aimage\/.*\Z/
end
