class AddHrefToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants, :href,:string
  end
end
