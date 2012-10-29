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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121029154506) do

  create_table "audits", :force => true do |t|
    t.integer  "store_id"
    t.integer  "environment_type_id"
    t.integer  "channel_id"
    t.integer  "retailer_id"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "audits", ["channel_id"], :name => "index_audits_on_channel_id"
  add_index "audits", ["environment_type_id"], :name => "index_audits_on_environment_type_id"
  add_index "audits", ["retailer_id"], :name => "index_audits_on_retailer_id"
  add_index "audits", ["store_id"], :name => "index_audits_on_store_id"
  add_index "audits", ["user_id"], :name => "index_audits_on_user_id"

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "owner"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "environment_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "locations", ["country_id"], :name => "index_locations_on_country_id"

  create_table "media_locations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "media_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "media_vehicles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "audit_id"
    t.integer  "category_id"
    t.integer  "media_location_id"
    t.integer  "media_vehicle_id"
    t.integer  "media_type_id"
    t.integer  "promotion_type_id"
    t.integer  "promotion_calendar_id"
    t.integer  "theme_id"
    t.text     "description"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "photos", ["audit_id"], :name => "index_photos_on_audit_id"
  add_index "photos", ["brand_id"], :name => "index_photos_on_brand_id"
  add_index "photos", ["category_id"], :name => "index_photos_on_category_id"
  add_index "photos", ["media_location_id"], :name => "index_photos_on_media_location_id"
  add_index "photos", ["media_type_id"], :name => "index_photos_on_media_type_id"
  add_index "photos", ["media_vehicle_id"], :name => "index_photos_on_media_vehicle_id"
  add_index "photos", ["promotion_calendar_id"], :name => "index_photos_on_promotion_calendar_id"
  add_index "photos", ["promotion_type_id"], :name => "index_photos_on_promotion_type_id"
  add_index "photos", ["theme_id"], :name => "index_photos_on_theme_id"

  create_table "promotion_calendars", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "promotion_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "retailers", :force => true do |t|
    t.string   "name"
    t.integer  "sector_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "retailers", ["sector_id"], :name => "index_retailers_on_sector_id"

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "store_formats", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "address2"
    t.string   "postcode"
    t.integer  "store_format_id"
    t.integer  "retailer_id"
    t.integer  "country_id"
    t.decimal  "longitude",       :precision => 15, :scale => 10
    t.decimal  "latitude",        :precision => 15, :scale => 10
    t.text     "description"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "sub_cats"
    t.string   "sub_country"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "themes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "sub_country"
    t.string   "sub_cats"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
