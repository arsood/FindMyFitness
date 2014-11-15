class AddAttachmentEventPhotoToEventPhotos < ActiveRecord::Migration
  def self.up
    change_table :event_photos do |t|
      t.attachment :event_photo
    end
  end

  def self.down
    remove_attachment :event_photos, :event_photo
  end
end
