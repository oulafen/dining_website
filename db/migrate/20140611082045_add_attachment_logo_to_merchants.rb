class AddAttachmentLogoToMerchants < ActiveRecord::Migration
  def self.up
    change_table :merchants do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :merchants, :logo
  end
end
