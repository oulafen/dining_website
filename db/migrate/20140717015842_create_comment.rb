class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :merchant_name
      t.string :user_name
      t.string :comment

    end
  end
end
