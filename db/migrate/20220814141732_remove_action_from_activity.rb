# frozen_string_literal: true

class RemoveActionFromActivity < ActiveRecord::Migration[6.1]
  def change
    remove_column :activities, :action, :integer
    remove_column :activities, :model, :integer
  end
end
