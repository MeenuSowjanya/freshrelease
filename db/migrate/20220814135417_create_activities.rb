# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :action
      t.integer :model
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
