class HomeAd < ActiveRecord::Base
  attr_accessible :photo_1, :photo_2, :photo_3, :photo_4, :photo_5,:photo_6,:photo_7, :photo_8, :photo_9, :photo_10, :photo_12,:photo_13,:photo_14,:photo_15,:photo_16
  has_attached_file :photo_1, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_1, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_2, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_2, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_3, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_3, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_4, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_4, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_5, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_5, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_6, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_6, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_7, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_7, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_8, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_8, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_9, :styles => { :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_9, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_10, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_10, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_11, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_11, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_12, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_12, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_13, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_13, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_14, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_14, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_15, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_15, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_16, :styles =>{ :small => "170x90>" },
                    :url  => "/assets/home_ads/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/home_ads/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_16, :content_type => ['image/jpeg', 'image/png','image/gif']

end
