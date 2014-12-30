class CreateDishLabel < ActiveRecord::Migration
  def change
    create_table :dish_labels do |t|
      t.integer   :dish_id
      t.integer   :label_id
    end
  end
end
