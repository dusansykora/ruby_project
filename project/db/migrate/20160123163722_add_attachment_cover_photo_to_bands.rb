class AddAttachmentCoverPhotoToBands < ActiveRecord::Migration
  def self.up
    change_table :bands do |t|
      t.attachment :cover_photo
    end
  end

  def self.down
    remove_attachment :bands, :cover_photo
  end
end
