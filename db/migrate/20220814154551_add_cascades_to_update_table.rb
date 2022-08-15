class AddCascadesToUpdateTable < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :ticket_update_activities, :tickets
    add_foreign_key :ticket_update_activities, :tickets, on_delete: :cascade, on_update: :cascade
    add_column :ticket_update_activities, :before_update, :json
    add_column :ticket_update_activities, :after_update, :json
  end
end
