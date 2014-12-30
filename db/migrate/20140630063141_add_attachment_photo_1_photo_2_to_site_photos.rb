class AddAttachmentPhoto1Photo2ToSitePhotos < ActiveRecord::Migration
  def self.up
    change_table :site_photos do |t|
      t.attachment :photo_1
      t.attachment :photo_2
    end
  end

  def self.down
    drop_attached_file :site_photos, :photo_1
    drop_attached_file :site_photos, :photo_2
  end
end
