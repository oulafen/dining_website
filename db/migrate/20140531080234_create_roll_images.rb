class CreateRollImages < ActiveRecord::Migration
  def change
    create_table :roll_images do |t|

      t.timestamps
    end
  end
end
