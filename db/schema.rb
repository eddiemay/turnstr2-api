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

ActiveRecord::Schema.define(version: 20171219004451) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
  end

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "month"
    t.integer  "year"
    t.string   "title"
    t.string   "cover_image_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id", "month", "year"], name: "index_albums_on_user_id_and_month_and_year", unique: true, using: :btree
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.boolean  "is_approved",                    default: false
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body",             limit: 65535
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "favourites", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "favourite_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["favourite_user_id", "user_id"], name: "index_favourites_on_favourite_user_id_and_user_id", unique: true, using: :btree
    t.index ["user_id", "favourite_user_id"], name: "index_favourites_on_user_id_and_favourite_user_id", unique: true, using: :btree
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "likable_type"
    t.integer  "likable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id", using: :btree
    t.index ["user_id", "likable_type", "likable_id"], name: "index_likes_on_user_id_and_likable_type_and_likable_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "live_sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "session_id"
    t.boolean  "completed",                default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "token",      limit: 65535
    t.index ["session_id"], name: "index_live_sessions_on_session_id", using: :btree
    t.index ["user_id"], name: "index_live_sessions_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.date     "captured_date"
    t.string   "visibility"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "album_id"
    t.integer  "likes_count",        default: 0
    t.integer  "comments_count",     default: 0
    t.index ["album_id"], name: "index_photos_on_album_id", using: :btree
    t.index ["visibility"], name: "index_photos_on_user_id_and_visibility", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "rpush_apps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                              null: false
    t.string   "environment"
    t.text     "certificate",             limit: 65535
    t.string   "password"
    t.integer  "connections",                           default: 1, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "type",                                              null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree
  end

  create_table "rpush_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound"
    t.text     "alert",             limit: 65535
    t.text     "data",              limit: 65535
    t.integer  "expiry",                             default: 86400
    t.boolean  "delivered",                          default: false, null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                             default: false, null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description", limit: 65535
    t.datetime "deliver_after"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "alert_is_json",                      default: false
    t.string   "type",                                               null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",                   default: false, null: false
    t.text     "registration_ids",  limit: 16777215
    t.integer  "app_id",                                             null: false
    t.integer  "retries",                            default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                         default: false, null: false
    t.integer  "priority"
    t.text     "url_args",          limit: 65535
    t.string   "category"
    t.boolean  "content_available",                  default: false
    t.text     "notification",      limit: 65535
    t.boolean  "mutable_content",                    default: false
    t.index ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi", using: :btree
    t.index ["delivered", "failed"], name: "index_rpush_notifications_multi", using: :btree
  end

  create_table "stories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "caption"
    t.integer  "likes_count",                    default: 0
    t.integer  "comments_count",                 default: 0
    t.string   "face1_video_thumb_file_name"
    t.string   "face1_video_thumb_content_type"
    t.integer  "face1_video_thumb_file_size"
    t.datetime "face1_video_thumb_updated_at"
    t.string   "face2_video_thumb_file_name"
    t.string   "face2_video_thumb_content_type"
    t.integer  "face2_video_thumb_file_size"
    t.datetime "face2_video_thumb_updated_at"
    t.string   "face3_video_thumb_file_name"
    t.string   "face3_video_thumb_content_type"
    t.integer  "face3_video_thumb_file_size"
    t.datetime "face3_video_thumb_updated_at"
    t.string   "face4_video_thumb_file_name"
    t.string   "face4_video_thumb_content_type"
    t.integer  "face4_video_thumb_file_size"
    t.datetime "face4_video_thumb_updated_at"
    t.string   "face1_media_file_name"
    t.string   "face1_media_content_type"
    t.integer  "face1_media_file_size"
    t.datetime "face1_media_updated_at"
    t.string   "face2_media_file_name"
    t.string   "face2_media_content_type"
    t.integer  "face2_media_file_size"
    t.datetime "face2_media_updated_at"
    t.string   "face3_media_file_name"
    t.string   "face3_media_content_type"
    t.integer  "face3_media_file_size"
    t.datetime "face3_media_updated_at"
    t.string   "face4_media_file_name"
    t.string   "face4_media_content_type"
    t.integer  "face4_media_file_size"
    t.datetime "face4_media_updated_at"
    t.boolean  "active",                         default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "face5_video_thumb_file_name"
    t.string   "face5_video_thumb_content_type"
    t.integer  "face5_video_thumb_file_size"
    t.datetime "face5_video_thumb_updated_at"
    t.string   "face6_video_thumb_file_name"
    t.string   "face6_video_thumb_content_type"
    t.integer  "face6_video_thumb_file_size"
    t.datetime "face6_video_thumb_updated_at"
    t.string   "face5_media_file_name"
    t.string   "face5_media_content_type"
    t.integer  "face5_media_file_size"
    t.datetime "face5_media_updated_at"
    t.string   "face6_media_file_name"
    t.string   "face6_media_content_type"
    t.integer  "face6_media_file_size"
    t.datetime "face6_media_updated_at"
    t.integer  "sequence",                       default: 0
    t.index ["user_id"], name: "index_stories_on_user_id", using: :btree
  end

  create_table "user_devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "device_udid"
    t.string   "device_push_token"
    t.string   "device_name"
    t.string   "device_ios"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "voip_token"
    t.string   "session_id"
    t.index ["device_udid", "user_id"], name: "index_user_devices_on_device_udid_and_user_id", unique: true, using: :btree
    t.index ["device_udid"], name: "index_user_devices_on_device_udid", using: :btree
    t.index ["user_id"], name: "index_user_devices_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "avatar_face1_file_name"
    t.string   "avatar_face1_content_type"
    t.integer  "avatar_face1_file_size"
    t.datetime "avatar_face1_updated_at"
    t.string   "avatar_face2_file_name"
    t.string   "avatar_face2_content_type"
    t.integer  "avatar_face2_file_size"
    t.datetime "avatar_face2_updated_at"
    t.string   "avatar_face3_file_name"
    t.string   "avatar_face3_content_type"
    t.integer  "avatar_face3_file_size"
    t.datetime "avatar_face3_updated_at"
    t.string   "avatar_face4_file_name"
    t.string   "avatar_face4_content_type"
    t.integer  "avatar_face4_file_size"
    t.datetime "avatar_face4_updated_at"
    t.string   "avatar_face5_file_name"
    t.string   "avatar_face5_content_type"
    t.integer  "avatar_face5_file_size"
    t.datetime "avatar_face5_updated_at"
    t.string   "avatar_face6_file_name"
    t.string   "avatar_face6_content_type"
    t.integer  "avatar_face6_file_size"
    t.datetime "avatar_face6_updated_at"
    t.string   "fb_token"
    t.string   "website"
    t.string   "bio"
    t.string   "gender"
    t.string   "remember_token"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "post_count",                              default: 0
    t.integer  "following_count",                         default: 0
    t.integer  "follower_count",                          default: 0
    t.integer  "family_count",                            default: 0
    t.text     "info",                      limit: 65535
    t.string   "contact_me"
    t.boolean  "online",                                  default: false
    t.boolean  "is_verified",                             default: false
    t.boolean  "is_active",                               default: true
    t.string   "role"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.bigint   "fb_user_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["fb_user_id"], name: "index_users_on_fb_user_id", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "albums", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "live_sessions", "users"
  add_foreign_key "photos", "albums"
  add_foreign_key "relationships", "users", column: "followed_id"
  add_foreign_key "relationships", "users", column: "follower_id"
  add_foreign_key "stories", "users"
  add_foreign_key "user_devices", "users"
end
