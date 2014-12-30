class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string "title"
      t.string "content",default: "请输入内容..."

      t.timestamps
    end
  end
end
