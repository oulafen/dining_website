class CreateSitePhotos < ActiveRecord::Migration
  def change
    create_table :site_photos do |t|

      t.timestamps
    end
  end
end
