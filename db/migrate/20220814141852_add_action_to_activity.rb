# frozen_string_literal: true

class AddActionToActivity < ActiveRecord::Migration[6.1]
  def change
    add_reference :activities, :action, null: false, foreign_key: true
    add_reference :activities, :activity_model, null: false, foreign_key: true
  end
end
