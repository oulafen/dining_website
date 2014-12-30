class DeletePhoto < ActiveRecord::Migration
  def change
    remove_column :dishes ,:photo

  end
end
