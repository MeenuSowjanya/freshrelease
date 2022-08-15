# frozen_string_literal: true

class CreateTicketCdActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_cd_activities do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
