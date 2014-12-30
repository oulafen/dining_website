class RollImage < ActiveRecord::Base
  attr_accessible :photo_1, :photo_2, :photo_3, :photo_4, :photo_5
  has_attached_file :photo_1, :styles => { :small => "700x200>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_1, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_2, :styles => { :small => "700x200>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_2, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_3, :styles => { :small => "700x200>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_3, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_4, :styles => { :small => "700x200>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_4, :content_type => ['image/jpeg', 'image/png','image/gif']

  has_attached_file :photo_5, :styles => { :small => "700x200>" },
                    :url  => "/assets/merchants/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/merchants/:id/:style/:basename.:extension"
  validates_attachment_content_type :photo_5, :content_type => ['image/jpeg', 'image/png','image/gif']

  def self.get_roll_image
    roll_images = []
    roll_image = RollImage.first
    if roll_image && roll_image.photo_1.url(:small) != "/photo_1s/small/missing.png"
      roll_images.push(roll_image.photo_1.url(:small))
    end
    if roll_image && roll_image.photo_2.url(:small) != "/photo_2s/small/missing.png"
      roll_images.push(roll_image.photo_2.url(:small))
    end
    if roll_image && roll_image.photo_3.url(:small) != "/photo_3s/small/missing.png"
      roll_images.push(roll_image.photo_3.url(:small))
    end
    if roll_image && roll_image.photo_4.url(:small) != "/photo_4s/small/missing.png"
      roll_images.push(roll_image.photo_4.url(:small))
    end
    if roll_image && roll_image.photo_5.url(:small) != "/photo_5s/small/missing.png"
      roll_images.push(roll_image.photo_5.url(:small))
    end
    roll_images
  end
end
