# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_09_215959) do

  create_table "awards", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "business_id"
    t.string "name"
    t.string "description"
    t.integer "year"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_subtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "business_type_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "business_subtypes_businesses", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "business_subtype_id"
    t.index ["business_id"], name: "index_business_subtypes_businesses_on_business_id"
    t.index ["business_subtype_id"], name: "index_business_subtypes_businesses_on_business_subtype_id"
  end

  create_table "business_types", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "title_for_subtypes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "businesses", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer "business_type_id"
    t.string "hours"
    t.string "website"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "phonenum"
    t.string "email"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "yelp_url"
    t.boolean "happy_hour"
    t.bigint "owner_id"
    t.string "status", default: "business_info"
    t.boolean "approved"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "lng", precision: 10, scale: 6
    t.boolean "pause_listing"
    t.boolean "food_truck"
    t.integer "region_id"
    t.index ["owner_id"], name: "index_businesses_on_owner_id"
  end

  create_table "businesses_service_types", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "service_type_id"
    t.index ["business_id"], name: "index_businesses_service_types_on_business_id"
    t.index ["service_type_id"], name: "index_businesses_service_types_on_service_type_id"
  end

  create_table "businesses_zones", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "business_id"
    t.bigint "zone_id"
    t.index ["business_id"], name: "index_businesses_zones_on_business_id"
    t.index ["zone_id"], name: "index_businesses_zones_on_zone_id"
  end

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "business_id"
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "phonenum"
    t.string "email"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "default_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "homepage_banner_image_file_name"
    t.string "homepage_banner_image_content_type"
    t.bigint "homepage_banner_image_file_size"
    t.datetime "homepage_banner_image_updated_at"
    t.string "homepage_general_instruction_image_file_name"
    t.string "homepage_general_instruction_image_content_type"
    t.bigint "homepage_general_instruction_image_file_size"
    t.datetime "homepage_general_instruction_image_updated_at"
    t.string "homepage_registration_image_file_name"
    t.string "homepage_registration_image_content_type"
    t.bigint "homepage_registration_image_file_size"
    t.datetime "homepage_registration_image_updated_at"
    t.text "home_welcome_text"
    t.text "general_instructions"
    t.text "registration_text"
    t.string "confirmation_from_email"
    t.string "contact_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "registered_welcome_text"
    t.string "registered_welcome_image_file_name"
    t.string "registered_welcome_image_content_type"
    t.bigint "registered_welcome_image_file_size"
    t.datetime "registered_welcome_image_updated_at"
  end

  create_table "default_settings_emails", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "email_from_address"
    t.string "email_subject"
    t.text "email_pretext"
    t.text "email_posttext"
    t.boolean "show_contact_info", default: true
    t.boolean "show_business_info", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "zone_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "service_types", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "sales_role", default: false
    t.boolean "user_role", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zones", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "businesses", "users", column: "owner_id"
end
