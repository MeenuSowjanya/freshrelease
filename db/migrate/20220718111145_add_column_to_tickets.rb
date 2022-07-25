class AddColumnToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :agent, :string
  end
end
