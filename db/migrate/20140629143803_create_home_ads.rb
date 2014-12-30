class CreateHomeAds < ActiveRecord::Migration
  def change
    create_table :home_ads do |t|

      t.timestamps
    end
  end
end
