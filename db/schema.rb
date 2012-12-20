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

ActiveRecord::Schema.define(:version => 20121218162634) do

  create_table "audits", :force => true do |t|
    t.integer  "store_id"
    t.integer  "environment_type_id"
    t.integer  "channel_id"
    t.integer  "retailer_id"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "reference"
  end

  add_index "audits", ["channel_id"], :name => "index_audits_on_channel_id"
  add_index "audits", ["environment_type_id"], :name => "index_audits_on_environment_type_id"
  add_index "audits", ["store_id"], :name => "index_audits_on_store_id"
  add_index "audits", ["user_id"], :name => "index_audits_on_user_id"

  create_table "brand_owners", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "brandings", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "brand_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "brandings", ["brand_id"], :name => "index_brandings_on_brand_id"
  add_index "brandings", ["photo_id"], :name => "index_brandings_on_photo_id"

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "brand_owner_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["photo_id"], :name => "index_categorizations_on_photo_id"

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

  create_table "medialocations", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "media_location_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "medialocations", ["media_location_id"], :name => "index_medialocations_on_media_location_id"
  add_index "medialocations", ["photo_id"], :name => "index_medialocations_on_photo_id"

  create_table "mediatypes", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "media_type_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mediatypes", ["media_type_id"], :name => "index_mediatypes_on_media_type_id"
  add_index "mediatypes", ["photo_id"], :name => "index_mediatypes_on_photo_id"

  create_table "mediavehicles", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "media_vehicle_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "mediavehicles", ["media_vehicle_id"], :name => "index_mediavehicles_on_media_vehicle_id"
  add_index "mediavehicles", ["photo_id"], :name => "index_mediavehicles_on_photo_id"

  create_table "photos", :force => true do |t|
    t.integer  "audit_id"
    t.integer  "promotion_calendar_id"
    t.text     "description"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "additional_brands"
    t.boolean  "published",             :default => false
    t.string   "headline"
    t.boolean  "display_for_project",   :default => false
    t.boolean  "brand_compliant",       :default => false
    t.string   "insight"
    t.string   "role_of_comm"
    t.string   "perspective"
    t.boolean  "data_complete"
  end

  add_index "photos", ["audit_id"], :name => "index_photos_on_audit_id"
  add_index "photos", ["promotion_calendar_id"], :name => "index_photos_on_promotion_calendar_id"

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

  create_table "promotiontypes", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "promotion_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "promotiontypes", ["photo_id"], :name => "index_promotiontypes_on_photo_id"
  add_index "promotiontypes", ["promotion_type_id"], :name => "index_promotiontypes_on_promotion_type_id"

  create_table "retailers", :force => true do |t|
    t.string   "name"
    t.integer  "sector_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "retailers", ["sector_id"], :name => "index_retailers_on_sector_id"

  create_table "save_searches", :force => true do |t|
    t.string   "name"
    t.text     "params"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "save_searches", ["user_id"], :name => "index_save_searches_on_user_id"

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

  add_index "stores", ["country_id"], :name => "index_stores_on_country_id"
  add_index "stores", ["retailer_id"], :name => "index_stores_on_retailer_id"
  add_index "stores", ["store_format_id"], :name => "index_stores_on_store_format_id"

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

  create_table "themings", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "theme_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "themings", ["photo_id"], :name => "index_themings_on_photo_id"
  add_index "themings", ["theme_id"], :name => "index_themings_on_theme_id"

  create_table "user_types", :force => true do |t|
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
    t.integer  "user_type_id",           :default => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
