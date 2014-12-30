class AddTableMerchantLabels < ActiveRecord::Migration
  def change
    create_table :merchant_labels do |t|
      t.integer :user_id
      t.integer :label_id
    end


  end
end
