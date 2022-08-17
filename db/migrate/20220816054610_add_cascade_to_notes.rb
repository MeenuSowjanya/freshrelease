# frozen_string_literal: true

class AddCascadeToNotes < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :notes, :tickets
    add_foreign_key :notes, :tickets, on_delete: :cascade, on_update: :cascade
  end
end
