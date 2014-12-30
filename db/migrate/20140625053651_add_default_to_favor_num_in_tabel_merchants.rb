class AddDefaultToFavorNumInTabelMerchants < ActiveRecord::Migration
  def change
    remove_column :merchants,:favor_num,:integer
    add_column :merchants,:favor_num,:integer ,:default => 0
  end
end
