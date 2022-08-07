class AddScreenshotsToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :screenshots, :binary
  end
end
