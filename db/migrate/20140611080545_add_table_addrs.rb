class AddTableAddrs < ActiveRecord::Migration
  def change
    create_table :addrs do |t|
      t.integer :user_id
      t.string  :address
      t.string  :phone
    end

  end
end
