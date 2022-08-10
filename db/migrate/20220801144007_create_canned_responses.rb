# frozen_string_literal: true

class CreateCannedResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :canned_responses do |t|
      t.string :subject
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
