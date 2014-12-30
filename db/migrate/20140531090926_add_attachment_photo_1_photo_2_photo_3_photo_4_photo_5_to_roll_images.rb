class AddAttachmentPhoto1Photo2Photo3Photo4Photo5ToRollImages < ActiveRecord::Migration
  def self.up
    change_table :roll_images do |t|
      t.attachment :photo_1
      t.attachment :photo_2
      t.attachment :photo_3
      t.attachment :photo_4
      t.attachment :photo_5
    end
  end

  def self.down
    drop_attached_file :roll_images, :photo_1
    drop_attached_file :roll_images, :photo_2
    drop_attached_file :roll_images, :photo_3
    drop_attached_file :roll_images, :photo_4
    drop_attached_file :roll_images, :photo_5
  end
end
