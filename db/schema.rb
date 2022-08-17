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

ActiveRecord::Schema.define(version: 20_220_816_122_438) do
  create_table 'actions', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'action'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'active_storage_attachments', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci',
                                                 force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'activities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'action_id', null: false
    t.bigint 'activity_model_id', null: false
    t.bigint 'ticket_id', null: false
    t.index ['action_id'], name: 'index_activities_on_action_id'
    t.index ['activity_model_id'], name: 'index_activities_on_activity_model_id'
    t.index ['ticket_id'], name: 'index_activities_on_ticket_id'
    t.index ['user_id'], name: 'index_activities_on_user_id'
  end

  create_table 'activity_models', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'model'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'agents', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'organisation_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['organisation_id'], name: 'index_agents_on_organisation_id'
    t.index ['user_id'], name: 'index_agents_on_user_id'
  end

  create_table 'canned_responses', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'subject'
    t.string 'description'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_canned_responses_on_user_id'
  end

  create_table 'note_cd_actvities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'ticket_id', null: false
    t.bigint 'note_id', null: false
    t.bigint 'activity_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['activity_id'], name: 'index_note_cd_actvities_on_activity_id'
    t.index ['note_id'], name: 'index_note_cd_actvities_on_note_id'
    t.index ['ticket_id'], name: 'index_note_cd_actvities_on_ticket_id'
  end

  create_table 'note_update_activities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'activity_id', null: false
    t.bigint 'ticket_id', null: false
    t.bigint 'note_id', null: false
    t.json 'before_update'
    t.json 'after_update'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['activity_id'], name: 'index_note_update_activities_on_activity_id'
    t.index ['note_id'], name: 'index_note_update_activities_on_note_id'
    t.index ['ticket_id'], name: 'index_note_update_activities_on_ticket_id'
  end

  create_table 'notes', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'note'
    t.bigint 'user_id', null: false
    t.bigint 'ticket_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.binary 'images'
    t.index ['ticket_id'], name: 'index_notes_on_ticket_id'
    t.index ['user_id'], name: 'index_notes_on_user_id'
  end

  create_table 'organisations', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'org_name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'priorities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'priority'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'statuses', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'ticket_cd_activities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'activity_id', null: false
    t.bigint 'ticket_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['activity_id'], name: 'index_ticket_cd_activities_on_activity_id'
    t.index ['ticket_id'], name: 'index_ticket_cd_activities_on_ticket_id'
  end

  create_table 'ticket_update_activities', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'activity_id', null: false
    t.bigint 'ticket_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.json 'before_update'
    t.json 'after_update'
    t.index ['activity_id'], name: 'index_ticket_update_activities_on_activity_id'
    t.index ['ticket_id'], name: 'index_ticket_update_activities_on_ticket_id'
  end

  create_table 'tickets', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'subject'
    t.string 'source'
    t.string 'impact'
    t.string 'urgency'
    t.string 'description'
    t.string 'agent'
    t.bigint 'user_id', null: false
    t.bigint 'priority_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'status_id', null: false
    t.binary 'screenshots'
    t.index ['priority_id'], name: 'index_tickets_on_priority_id'
    t.index ['status_id'], name: 'index_tickets_on_status_id'
    t.index ['user_id'], name: 'index_tickets_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'password_digest'
    t.string 'role', default: 'agent'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'activities', 'actions'
  add_foreign_key 'activities', 'activity_models'
  add_foreign_key 'activities', 'users'
  add_foreign_key 'agents', 'organisations', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'agents', 'users', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'canned_responses', 'users', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'note_cd_actvities', 'activities', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'note_cd_actvities', 'notes', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'note_cd_actvities', 'tickets', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'note_update_activities', 'activities'
  add_foreign_key 'note_update_activities', 'notes', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'note_update_activities', 'tickets'
  add_foreign_key 'notes', 'tickets', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'notes', 'users', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'ticket_cd_activities', 'activities'
  add_foreign_key 'ticket_cd_activities', 'tickets', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'ticket_update_activities', 'activities'
  add_foreign_key 'ticket_update_activities', 'tickets', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'tickets', 'priorities', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'tickets', 'statuses', on_update: :cascade, on_delete: :cascade
  add_foreign_key 'tickets', 'users', on_update: :cascade, on_delete: :cascade
end
