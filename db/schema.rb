# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140722023948) do

  create_table "addrs", force: true do |t|
    t.integer "user_id"
    t.string  "address"
    t.string  "phone"
  end

  create_table "comments", force: true do |t|
    t.string   "merchant_name"
    t.string   "user_name"
    t.string   "comment"
    t.datetime "created_at"
  end

  create_table "dish_labels", force: true do |t|
    t.integer "dish_id"
    t.integer "label_id"
  end

  create_table "dishes", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "price"
    t.string   "remark"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "favors", force: true do |t|
    t.integer  "user_id"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "home_ads", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_1_file_name"
    t.string   "photo_1_content_type"
    t.integer  "photo_1_file_size"
    t.datetime "photo_1_updated_at"
    t.string   "photo_2_file_name"
    t.string   "photo_2_content_type"
    t.integer  "photo_2_file_size"
    t.datetime "photo_2_updated_at"
    t.string   "photo_3_file_name"
    t.string   "photo_3_content_type"
    t.integer  "photo_3_file_size"
    t.datetime "photo_3_updated_at"
    t.string   "photo_4_file_name"
    t.string   "photo_4_content_type"
    t.integer  "photo_4_file_size"
    t.datetime "photo_4_updated_at"
    t.string   "photo_5_file_name"
    t.string   "photo_5_content_type"
    t.integer  "photo_5_file_size"
    t.datetime "photo_5_updated_at"
    t.string   "photo_6_file_name"
    t.string   "photo_6_content_type"
    t.integer  "photo_6_file_size"
    t.datetime "photo_6_updated_at"
    t.string   "photo_7_file_name"
    t.string   "photo_7_content_type"
    t.integer  "photo_7_file_size"
    t.datetime "photo_7_updated_at"
    t.string   "photo_8_file_name"
    t.string   "photo_8_content_type"
    t.integer  "photo_8_file_size"
    t.datetime "photo_8_updated_at"
    t.string   "photo_9_file_name"
    t.string   "photo_9_content_type"
    t.integer  "photo_9_file_size"
    t.datetime "photo_9_updated_at"
    t.string   "photo_10_file_name"
    t.string   "photo_10_content_type"
    t.integer  "photo_10_file_size"
    t.datetime "photo_10_updated_at"
    t.string   "photo_11_file_name"
    t.string   "photo_11_content_type"
    t.integer  "photo_11_file_size"
    t.datetime "photo_11_updated_at"
    t.string   "photo_12_file_name"
    t.string   "photo_12_content_type"
    t.integer  "photo_12_file_size"
    t.datetime "photo_12_updated_at"
    t.string   "photo_13_file_name"
    t.string   "photo_13_content_type"
    t.integer  "photo_13_file_size"
    t.datetime "photo_13_updated_at"
    t.string   "photo_14_file_name"
    t.string   "photo_14_content_type"
    t.integer  "photo_14_file_size"
    t.datetime "photo_14_updated_at"
    t.string   "photo_15_file_name"
    t.string   "photo_15_content_type"
    t.integer  "photo_15_file_size"
    t.datetime "photo_15_updated_at"
    t.string   "photo_16_file_name"
    t.string   "photo_16_content_type"
    t.integer  "photo_16_file_size"
    t.datetime "photo_16_updated_at"
  end

  create_table "labels", force: true do |t|
    t.string  "content"
    t.string  "category"
    t.integer "category_id"
    t.string  "site"
    t.string  "postcode"
    t.string  "create_type"
  end

  create_table "merchant_labels", force: true do |t|
    t.integer "user_id"
    t.integer "label_id"
  end

  create_table "merchants", force: true do |t|
    t.string   "user_name"
    t.string   "restaurant_name"
    t.string   "password_digest"
    t.string   "login_type",        default: "user"
    t.string   "addr"
    t.string   "phone"
    t.string   "remark"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "status"
    t.string   "email"
    t.integer  "private_cuisine"
    t.time     "time_from"
    t.time     "time_to"
    t.integer  "favor_num",         default: 0
    t.integer  "outer_sell"
    t.string   "href"
  end

  create_table "roll_images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_1_file_name"
    t.string   "photo_1_content_type"
    t.integer  "photo_1_file_size"
    t.datetime "photo_1_updated_at"
    t.string   "photo_2_file_name"
    t.string   "photo_2_content_type"
    t.integer  "photo_2_file_size"
    t.datetime "photo_2_updated_at"
    t.string   "photo_3_file_name"
    t.string   "photo_3_content_type"
    t.integer  "photo_3_file_size"
    t.datetime "photo_3_updated_at"
    t.string   "photo_4_file_name"
    t.string   "photo_4_content_type"
    t.integer  "photo_4_file_size"
    t.datetime "photo_4_updated_at"
    t.string   "photo_5_file_name"
    t.string   "photo_5_content_type"
    t.integer  "photo_5_file_size"
    t.datetime "photo_5_updated_at"
  end

  create_table "site_photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_1_file_name"
    t.string   "photo_1_content_type"
    t.integer  "photo_1_file_size"
    t.datetime "photo_1_updated_at"
    t.string   "photo_2_file_name"
    t.string   "photo_2_content_type"
    t.integer  "photo_2_file_size"
    t.datetime "photo_2_updated_at"
  end

  create_table "texts", force: true do |t|
    t.string   "title"
    t.string   "content",    default: "请输入内容..."
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "status",          default: "checking"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "active_num"
  end

end
