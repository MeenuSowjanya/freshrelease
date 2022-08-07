class RemovePriorityFromTickets < ActiveRecord::Migration[6.1]
  def change
    remove_column :tickets, :priority, :string
  end
end
