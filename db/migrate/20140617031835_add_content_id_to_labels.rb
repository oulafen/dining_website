class AddContentIdToLabels < ActiveRecord::Migration
  def change
    add_column :labels,:content_id,:string
  end
end
