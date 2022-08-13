# frozen_string_literal: true

class AddImagesToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :images, :binary
  end
end
