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

ActiveRecord::Schema.define(version: 20150113190423) do

  create_table "blog_comments", force: true do |t|
    t.integer  "blog_id"
    t.integer  "commentor_id"
    t.text     "blog_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_photos", force: true do |t|
    t.string   "post_id"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post_photo_file_name"
    t.string   "post_photo_content_type"
    t.integer  "post_photo_file_size"
    t.datetime "post_photo_updated_at"
  end

  create_table "blog_tags", force: true do |t|
    t.integer  "blog_id"
    t.string   "blog_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: true do |t|
    t.integer  "user_id"
    t.string   "post_id"
    t.text     "post_text"
    t.string   "post_title"
    t.string   "post_privacy", default: "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_photos", force: true do |t|
    t.string   "business_hash"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_photo_file_name"
    t.string   "business_photo_content_type"
    t.integer  "business_photo_file_size"
    t.datetime "business_photo_updated_at"
  end

  create_table "business_saves", force: true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_services", force: true do |t|
    t.integer  "bus_id"
    t.string   "bus_service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_views", force: true do |t|
    t.integer  "business_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "business_type"
    t.string   "business_hash"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "phone"
    t.string   "website"
    t.string   "availability"
    t.text     "description"
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "views",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_photos", force: true do |t|
    t.string   "event_id"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_photo_file_name"
    t.string   "event_photo_content_type"
    t.integer  "event_photo_file_size"
    t.datetime "event_photo_updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "event_name"
    t.text     "event_description"
    t.string   "event_category"
    t.string   "event_location"
    t.datetime "event_date"
    t.string   "event_time"
    t.string   "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "notification_type"
    t.integer  "item_id"
    t.integer  "guest_user_id"
    t.integer  "owner_user_id"
    t.boolean  "dismissed",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "bus_id"
    t.integer  "star_rating"
    t.text     "review_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email_address"
    t.text     "about_me"
    t.string   "username"
    t.string   "password"
    t.string   "password_digest"
    t.string   "user_type"
    t.string   "city"
    t.string   "state"
    t.string   "auth_id"
    t.string   "fb_img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
