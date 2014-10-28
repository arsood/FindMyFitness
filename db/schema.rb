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

ActiveRecord::Schema.define(version: 20141028183426) do

  create_table "business_services", force: true do |t|
    t.integer  "bus_id"
    t.string   "bus_service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "business_type"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.integer  "phone"
    t.string   "website"
    t.string   "monday_start"
    t.string   "monday_end"
    t.string   "tuesday_start"
    t.string   "tuesday_end"
    t.string   "wednesday_start"
    t.string   "wednesday_end"
    t.string   "thursday_start"
    t.string   "thursday_end"
    t.string   "friday_start"
    t.string   "friday_end"
    t.string   "saturday_start"
    t.string   "saturday_end"
    t.string   "sunday_start"
    t.string   "sunday_end"
    t.text     "description"
    t.integer  "views"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
