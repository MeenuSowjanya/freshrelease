# frozen_string_literal: true

class CreatePriorities < ActiveRecord::Migration[6.1]
  def change
    create_table :priorities do |t|
      t.string :priority
      t.timestamps
    end
  end
end
