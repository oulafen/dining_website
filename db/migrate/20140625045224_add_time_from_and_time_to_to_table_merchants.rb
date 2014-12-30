class AddTimeFromAndTimeToToTableMerchants < ActiveRecord::Migration
  def change
    add_column :merchants,:time_from,:time
    add_column :merchants,:time_to,:time
  end
end
