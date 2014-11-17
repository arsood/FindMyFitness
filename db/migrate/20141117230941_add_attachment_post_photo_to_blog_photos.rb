class AddAttachmentPostPhotoToBlogPhotos < ActiveRecord::Migration
  def self.up
    change_table :blog_photos do |t|
      t.attachment :post_photo
    end
  end

  def self.down
    remove_attachment :blog_photos, :post_photo
  end
end
