class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :source
      t.string :status
      t.string :impact
      t.string :urgency
      t.string :priority
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
