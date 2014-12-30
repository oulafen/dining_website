class ModifyColumnInMerchants < ActiveRecord::Migration
  def change
    remove_column :merchants,:outer_sell,:string
    add_column :merchants,:outer_sell,:integer
  end
end
