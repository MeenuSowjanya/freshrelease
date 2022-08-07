class AddCascadeToReferences < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :tickets, :users
    add_foreign_key :tickets, :users, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :tickets, :priorities
    add_foreign_key :tickets, :priorities, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :tickets, :statuses
    add_foreign_key :tickets, :statuses, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :agents, :users
    add_foreign_key :agents, :users, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :notes, :users
    add_foreign_key :notes, :users, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :agents, :organisations
    add_foreign_key :agents, :organisations, on_delete: :cascade, on_update: :cascade
    remove_foreign_key :canned_responses, :users
    add_foreign_key :canned_responses, :users, on_delete: :cascade, on_update: :cascade
  end
end
