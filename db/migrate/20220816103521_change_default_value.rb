# frozen_string_literal: true

class ChangeDefaultValue < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :role, :string, default: 'agent'
  end
end
