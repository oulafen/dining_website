class AddTableLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string  :content
      t.string  :category
      t.integer :category_id
    end

  end
end
