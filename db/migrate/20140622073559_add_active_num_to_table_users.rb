class AddActiveNumToTableUsers < ActiveRecord::Migration
  def change
    add_column :users,:active_num,:string
  end
end
