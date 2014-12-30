class AddAttachmentPhoto1Photo2Photo3Photo4Photo5Photo6Photo7Photo8Photo9Photo10Photo11Photo12Photo13Photo14Photo15Photo16ToHomeAds < ActiveRecord::Migration
  def self.up
    change_table :home_ads do |t|
      t.attachment :photo_1
      t.attachment :photo_2
      t.attachment :photo_3
      t.attachment :photo_4
      t.attachment :photo_5
      t.attachment :photo_6
      t.attachment :photo_7
      t.attachment :photo_8
      t.attachment :photo_9
      t.attachment :photo_10
      t.attachment :photo_11
      t.attachment :photo_12
      t.attachment :photo_13
      t.attachment :photo_14
      t.attachment :photo_15
      t.attachment :photo_16
    end
  end

  def self.down
    drop_attached_file :home_ads, :photo_1
    drop_attached_file :home_ads, :photo_2
    drop_attached_file :home_ads, :photo_3
    drop_attached_file :home_ads, :photo_4
    drop_attached_file :home_ads, :photo_5
    drop_attached_file :home_ads, :photo_6
    drop_attached_file :home_ads, :photo_7
    drop_attached_file :home_ads, :photo_8
    drop_attached_file :home_ads, :photo_9
    drop_attached_file :home_ads, :photo_10
    drop_attached_file :home_ads, :photo_11
    drop_attached_file :home_ads, :photo_12
    drop_attached_file :home_ads, :photo_13
    drop_attached_file :home_ads, :photo_14
    drop_attached_file :home_ads, :photo_15
    drop_attached_file :home_ads, :photo_16
  end
end
