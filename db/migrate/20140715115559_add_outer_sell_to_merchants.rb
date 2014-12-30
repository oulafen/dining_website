class AddOuterSellToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :outer_sell, :string
  end
end
