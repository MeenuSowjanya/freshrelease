# frozen_string_literal: true

class AddCascadeToNotesReferences < ActiveRecord::Migration[6.1]
  def up
    # remove_foreign_key :notes, :tickets
    add_foreign_key :notes, :tickets, on_delete: :cascade, on_update: :cascade
  end
end
