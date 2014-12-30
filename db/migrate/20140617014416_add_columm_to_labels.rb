class AddColummToLabels < ActiveRecord::Migration
  def change
    add_column :labels,:html_content,:string
    add_column :labels,:short_html_content,:string
  end
end
