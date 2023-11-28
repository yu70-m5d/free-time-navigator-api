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

ActiveRecord::Schema[7.0].define(version: 2023_11_28_034224) do
  create_table "spots", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.float "latitude", limit: 53, null: false
    t.float "longitude", limit: 53, null: false
    t.float "rating"
    t.time "average_stay_time"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place_id"
    t.index ["name"], name: "index_spots_on_name", unique: true
    t.index ["place_id"], name: "place_id", unique: true
  end

  create_table "tags", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

end
