class CreateFavors < ActiveRecord::Migration
  def change
    create_table :favors do |t|
      t.integer :user_id
      t.integer :merchant_id

      t.timestamps
    end
  end
end
