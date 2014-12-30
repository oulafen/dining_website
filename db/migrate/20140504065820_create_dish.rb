class CreateDish < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.integer   :user_id
      t.string    :name
      t.integer   :price
      t.string    :remark
    end
  end
end
