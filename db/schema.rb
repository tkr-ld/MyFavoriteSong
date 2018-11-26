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

ActiveRecord::Schema.define(version: 20181126110124) do

  create_table "musician_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "musician_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["musician_id"], name: "index_musician_relationships_on_musician_id", using: :btree
    t.index ["user_id"], name: "index_musician_relationships_on_user_id", using: :btree
  end

  create_table "musicians", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "detail"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setlist_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "setlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setlist_id"], name: "index_setlist_relationships_on_setlist_id", using: :btree
    t.index ["user_id"], name: "index_setlist_relationships_on_user_id", using: :btree
  end

  create_table "setlists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "musician_id"
    t.string   "title"
    t.date     "date"
    t.string   "place"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["musician_id"], name: "index_setlists_on_musician_id", using: :btree
    t.index ["user_id"], name: "index_setlists_on_user_id", using: :btree
  end

  create_table "songs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "setlist_id"
    t.string   "title"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setlist_id"], name: "index_songs_on_setlist_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "musician_relationships", "musicians"
  add_foreign_key "musician_relationships", "users"
  add_foreign_key "setlist_relationships", "setlists"
  add_foreign_key "setlist_relationships", "users"
  add_foreign_key "setlists", "musicians"
  add_foreign_key "setlists", "users"
  add_foreign_key "songs", "setlists"
end
