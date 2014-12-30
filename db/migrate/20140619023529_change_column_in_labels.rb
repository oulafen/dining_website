class ChangeColumnInLabels < ActiveRecord::Migration
  def change
    rename_column :labels,:html_content,:site
    rename_column :labels,:short_html_content,:postcode
    rename_column :labels,:show_content,:create_type
  end
end
