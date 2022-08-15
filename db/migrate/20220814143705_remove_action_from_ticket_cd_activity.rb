class RemoveActionFromTicketCdActivity < ActiveRecord::Migration[6.1]
  def change
    remove_reference :ticket_cd_activities, :action, null: false, foreign_key: true
  end
end
