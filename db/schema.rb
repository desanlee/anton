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

ActiveRecord::Schema.define(:version => 20130524021832) do

  create_table "avlrelationships", :force => true do |t|
    t.integer  "system_id"
    t.integer  "device_id"
    t.integer  "user_id"
    t.integer  "maxnum"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "casetypes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "devices", :force => true do |t|
    t.integer  "devicetype_id"
    t.integer  "user_id"
    t.string   "name"
    t.integer  "countnum"
    t.string   "model"
    t.string   "pn"
    t.string   "note"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "devicetypes", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "positionname"
    t.string   "note"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "devicecate"
  end

  create_table "executions", :force => true do |t|
    t.integer  "sysconfig_id"
    t.integer  "testcase_id"
    t.integer  "user_id"
    t.string   "result"
    t.string   "bug"
    t.string   "note"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "device_id"
    t.integer  "sysconfigrelationship_id"
  end

  create_table "priviledges", :force => true do |t|
    t.integer  "user_id"
    t.string   "charactor"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "realconfigs", :force => true do |t|
    t.integer  "targetmatrix_id"
    t.integer  "device_id"
    t.string   "devicename"
    t.integer  "devicetype"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "suts", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "system_id"
    t.string   "spip"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "holder_id"
  end

  create_table "sysconfigrelationships", :force => true do |t|
    t.integer  "sysconfig_id"
    t.integer  "device_id"
    t.integer  "position"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "sysconfigs", :force => true do |t|
    t.integer  "sut_id"
    t.integer  "user_id"
    t.integer  "autoupdate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "systems", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "model"
    t.string   "pn"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "targetcaserelationships", :force => true do |t|
    t.integer  "testcase_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "targetenv_id"
  end

  create_table "targetcases", :force => true do |t|
    t.integer  "target_id"
    t.string   "casetype"
    t.integer  "casepara"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "targetdeprelationships", :force => true do |t|
    t.integer  "targetenv_id"
    t.integer  "device_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "targetenvrelationships", :force => true do |t|
    t.integer  "targetenv_id"
    t.integer  "device_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "targetenvs", :force => true do |t|
    t.integer  "target_id"
    t.string   "envtype"
    t.integer  "envpara"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "devicetype_id"
  end

  create_table "targetmatrices", :force => true do |t|
    t.integer  "targetenv_id"
    t.integer  "device_id"
    t.integer  "testcase_id"
    t.integer  "execution_id"
    t.datetime "update_time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "targets", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taskobjects", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "device_id"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "system_id"
  end

  create_table "testcases", :force => true do |t|
    t.integer  "casetype_id"
    t.string   "casecate"
    t.string   "name"
    t.integer  "user_id"
    t.string   "steps"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "devicetype_id"
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
