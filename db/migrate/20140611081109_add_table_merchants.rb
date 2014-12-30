class AddTableMerchants < ActiveRecord::Migration
  def change
    create_table "merchants", force: true do |t|
      t.string   "user_name"
      t.string   "restaurant_name"
      t.string   "password_digest"
      t.string   "login_type",        default: "user"
      t.string   "addr"
      t.string   "phone"
      t.string   "remark"
    end

  end
end
