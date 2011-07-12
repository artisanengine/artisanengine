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

ActiveRecord::Schema.define(:version => 20110623164147) do

  create_table "artisans", :force => true do |t|
    t.integer "frame_id",                                          :null => false
    t.string  "first_name",                                        :null => false
    t.string  "last_name",                                         :null => false
    t.string  "email",                             :default => "", :null => false
    t.string  "encrypted_password", :limit => 128, :default => "", :null => false
  end

  add_index "artisans", ["email"], :name => "index_artisans_on_email", :unique => true

  create_table "blogs", :force => true do |t|
    t.integer "frame_id", :null => false
    t.string  "name",     :null => false
  end

  add_index "blogs", ["id", "frame_id"], :name => "index_blogs_on_id_and_frame_id"

  create_table "collects", :force => true do |t|
    t.integer "display_case_id", :null => false
    t.integer "good_id",         :null => false
  end

  create_table "display_cases", :force => true do |t|
    t.integer "frame_id",    :null => false
    t.string  "name",        :null => false
    t.string  "cached_slug"
  end

  add_index "display_cases", ["id", "frame_id"], :name => "index_display_cases_on_id_and_frame_id"

  create_table "engineers", :force => true do |t|
    t.string "email",                             :default => "", :null => false
    t.string "encrypted_password", :limit => 128, :default => "", :null => false
  end

  create_table "frames", :force => true do |t|
    t.string "name",   :null => false
    t.string "domain", :null => false
  end

  add_index "frames", ["domain"], :name => "index_frames_on_domain", :unique => true

  create_table "goods", :force => true do |t|
    t.integer  "frame_id",         :null => false
    t.string   "name",             :null => false
    t.text     "description"
    t.text     "html_description"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goods", ["id", "frame_id"], :name => "index_goods_on_id_and_frame_id"

  create_table "image_attachers", :force => true do |t|
    t.integer "image_id",       :null => false
    t.integer "imageable_id",   :null => false
    t.string  "imageable_type", :null => false
    t.integer "display_order",  :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "frame_id",   :null => false
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["id", "frame_id"], :name => "index_images_on_id_and_frame_id"

  create_table "options", :force => true do |t|
    t.integer "good_id",       :null => false
    t.integer "order_in_good", :null => false
    t.string  "name",          :null => false
    t.string  "default_value", :null => false
  end

  add_index "options", ["id", "good_id"], :name => "index_options_on_id_and_good_id"

  create_table "pages", :force => true do |t|
    t.integer  "frame_id",     :null => false
    t.string   "title",        :null => false
    t.text     "content"
    t.text     "html_content"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["id", "frame_id"], :name => "index_pages_on_id_and_frame_id"

  create_table "posts", :force => true do |t|
    t.integer  "blog_id",      :null => false
    t.string   "title",        :null => false
    t.text     "content"
    t.text     "html_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["id", "blog_id"], :name => "index_posts_on_id_and_blog_id"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id",        :null => false
    t.integer "taggable_id",   :null => false
    t.string  "taggable_type", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "frame_id",    :null => false
    t.string   "name",        :null => false
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["id", "frame_id"], :name => "index_tags_on_id_and_frame_id"

  create_table "variants", :force => true do |t|
    t.integer "good_id",                       :null => false
    t.integer "display_order",                 :null => false
    t.integer "price_in_cents", :default => 0, :null => false
    t.string  "currency"
    t.string  "option_value_1"
    t.string  "option_value_2"
    t.string  "option_value_3"
    t.string  "option_value_4"
    t.string  "option_value_5"
  end

  add_index "variants", ["id", "good_id"], :name => "index_variants_on_id_and_good_id"

end
