class AddEmailAndStatusToMerchant < ActiveRecord::Migration
  def change
    add_column :merchants ,:status,:string
    add_column :merchants ,:email,:string
  end
end
