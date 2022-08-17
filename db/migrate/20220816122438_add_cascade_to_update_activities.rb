# frozen_string_literal: true

class AddCascadeToUpdateActivities < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :note_update_activities, :notes
    add_foreign_key :note_update_activities, :notes, on_delete: :cascade, on_update: :cascade
  end
end
