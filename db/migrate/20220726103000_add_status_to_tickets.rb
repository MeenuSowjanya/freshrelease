# frozen_string_literal: true

class AddStatusToTickets < ActiveRecord::Migration[6.1]
  def change
    add_reference :tickets, :status, null: false, foreign_key: true
  end
end
