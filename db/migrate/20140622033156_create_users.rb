class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string "name"
      t.string "password_digest"
      t.string "status", default: "checking"
      t.string "email"

      t.timestamps
    end
  end
end
