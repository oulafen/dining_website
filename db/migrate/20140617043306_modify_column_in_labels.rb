class ModifyColumnInLabels < ActiveRecord::Migration
  def change
    rename_column :labels ,:content_id,:show_content
  end
end
