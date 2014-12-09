class AddAttachmentBusinessPhotoToBusinessPhotos < ActiveRecord::Migration
  def self.up
    change_table :business_photos do |t|
      t.attachment :business_photo
    end
  end

  def self.down
    remove_attachment :business_photos, :business_photo
  end
end
