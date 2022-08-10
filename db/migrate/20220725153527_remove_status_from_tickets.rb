# frozen_string_literal: true

class RemoveStatusFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :status, :string
  end
end
