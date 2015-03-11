class AddAttachmentReviewPhotoToReviewphotos < ActiveRecord::Migration
  def self.up
    change_table :review_photos do |t|
      t.attachment :review_photo
    end
  end

  def self.down
    remove_attachment :review_photos, :review_photo
  end
end
