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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goods", ["id", "frame_id"], :name => "index_goods_on_id_and_frame_id"

  create_table "images", :force => true do |t|
    t.integer  "frame_id",   :null => false
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["id", "frame_id"], :name => "index_images_on_id_and_frame_id"

  create_table "options", :force => true do |t|
    t.integer "good_id", :null => false
    t.string  "name",    :null => false
    t.string  "default", :null => false
  end

  add_index "options", ["id", "good_id"], :name => "index_options_on_id_and_good_id"

  create_table "pages", :force => true do |t|
    t.integer  "frame_id",     :null => false
    t.string   "title",        :null => false
    t.text     "content"
    t.text     "html_content"
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

  create_table "taggings", :force => true do |t|
    t.integer "tag_id",        :null => false
    t.integer "taggable_id",   :null => false
    t.string  "taggable_type", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "frame_id",   :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["id", "frame_id"], :name => "index_tags_on_id_and_frame_id"

end
