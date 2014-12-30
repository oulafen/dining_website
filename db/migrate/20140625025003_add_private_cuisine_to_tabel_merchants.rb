class AddPrivateCuisineToTabelMerchants < ActiveRecord::Migration
  def change
    add_column :merchants,:private_cuisine,:integer
  end
end
