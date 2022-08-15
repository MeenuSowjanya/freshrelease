class AddCascadesToCdTable < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :ticket_cd_activities, :tickets
    add_foreign_key :ticket_cd_activities, :tickets, on_delete: :cascade, on_update: :cascade
  end
end
