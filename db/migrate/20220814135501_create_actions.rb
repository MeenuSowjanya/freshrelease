# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.string :action

      t.timestamps
    end
  end
end
