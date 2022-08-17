# frozen_string_literal: true

class CreateNoteUpdateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :note_update_activities do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.references :note, null: false, foreign_key: true
      t.json :before_update
      t.json :after_update

      t.timestamps
    end
  end
end
