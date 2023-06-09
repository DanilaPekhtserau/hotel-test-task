# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_429_142_347) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bills', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'room_id', null: false
    t.integer 'cost', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['room_id'], name: 'index_bills_on_room_id'
    t.index ['user_id'], name: 'index_bills_on_user_id'
  end

  create_table 'requests', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.integer 'places', default: 1, null: false
    t.string 'room_class', null: false
    t.integer 'time_of_stay', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_requests_on_user_id'
  end

  create_table 'rooms', force: :cascade do |t|
    t.integer 'places', default: 1, null: false
    t.string 'room_class', null: false
    t.integer 'price', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.boolean 'admin', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'authentication_token'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'bills', 'rooms'
  add_foreign_key 'bills', 'users'
  add_foreign_key 'requests', 'users'
end
