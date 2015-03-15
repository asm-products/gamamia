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

ActiveRecord::Schema.define(version: 20150315220949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content",        null: false
    t.integer  "user_id",        null: false
    t.integer  "game_id",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cached_content"
    t.integer  "parent_id"
  end

  add_index "comments", ["game_id"], name: "index_comments_on_game_id"
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "games", force: :cascade do |t|
    t.string   "title",                                 null: false
    t.string   "thumbnail"
    t.string   "description",                           null: false
    t.string   "status"
    t.string   "link",                                  null: false
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.integer  "videos_count",            default: 0
    t.integer  "comments_count",          default: 0
    t.date     "scheduled_at"
    t.datetime "deleted_at"
    t.integer  "user_id"
  end

  add_index "games", ["cached_votes_down"], name: "index_games_on_cached_votes_down"
  add_index "games", ["cached_votes_score"], name: "index_games_on_cached_votes_score"
  add_index "games", ["cached_votes_total"], name: "index_games_on_cached_votes_total"
  add_index "games", ["cached_votes_up"], name: "index_games_on_cached_votes_up"
  add_index "games", ["cached_weighted_average"], name: "index_games_on_cached_weighted_average"
  add_index "games", ["cached_weighted_score"], name: "index_games_on_cached_weighted_score"
  add_index "games", ["cached_weighted_total"], name: "index_games_on_cached_weighted_total"
  add_index "games", ["user_id"], name: "index_games_on_user_id"

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "occupation"
    t.text     "avatar_url"
    t.boolean  "receive_newsletter"
    t.string   "username",               default: "",   null: false
    t.string   "role"
    t.string   "twitter_handle"
    t.boolean  "email_notifications",    default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "thumbnail"
    t.string   "category"
    t.string   "embed",      null: false
    t.integer  "game_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["game_id"], name: "index_videos_on_game_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

  add_foreign_key "comments", "games", name: "comments_game_id_fk"
  add_foreign_key "comments", "users", name: "comments_user_id_fk"
  add_foreign_key "games", "users"
  add_foreign_key "games", "users", name: "games_user_id_fk"
  add_foreign_key "identities", "users", name: "identities_user_id_fk"
  add_foreign_key "videos", "games", name: "videos_game_id_fk"
end
