# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :source
      t.string :status
      t.string :impact
      t.string :urgency
      t.integer :priority
      t.string :description
      t.string :agent
      t.references :user, null: false, foreign_key: true
      t.references :priority, null: false, foreign_key: true
      t.timestamps
    end
  end
end
