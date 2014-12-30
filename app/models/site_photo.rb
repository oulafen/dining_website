class SitePhoto < ActiveRecord::Base
  attr_accessible :photo_1, :photo_2
  has_attached_file :photo_1,
                    :url  => "/assets/site_photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/site_photos/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_1, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_2, :styles => { :small => "135x60>" },
                    :url  => "/assets/site_photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/site_photos/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_2, :content_type => ['image/jpeg', 'image/png','image/gif']

end
