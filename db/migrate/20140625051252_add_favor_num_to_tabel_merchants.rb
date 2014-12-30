class AddFavorNumToTabelMerchants < ActiveRecord::Migration
  def change
    add_column :merchants,:favor_num,:integer
  end
end
