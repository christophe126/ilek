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

ActiveRecord::Schema[7.0].define(version: 2023_02_14_113156) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "wines", force: :cascade do |t|
    t.string "name", null: false
    t.integer "sku_id"
    t.integer "rating", null: false
    t.string "available"
    t.text "wine_description"
    t.string "wine_url"
    t.string "wine_img"
    t.string "wine_img_small"
    t.string "domaine"
    t.string "pays"
    t.string "region"
    t.string "couleur"
    t.integer "millesime"
    t.string "appellation"
    t.string "culture"
    t.string "cepages"
    t.string "degre_dalcool"
    t.string "temperature_de_service"
    t.string "boire_ou_garder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "classement"
    t.index ["appellation"], name: "index_wines_on_appellation"
    t.index ["couleur"], name: "index_wines_on_couleur"
    t.index ["millesime"], name: "index_wines_on_millesime"
    t.index ["name"], name: "index_wines_on_name"
    t.index ["rating"], name: "index_wines_on_rating"
    t.index ["region"], name: "index_wines_on_region"
  end

end
