# frozen_string_literal: true

class CreateOrganisations < ActiveRecord::Migration[6.1]
  def change
    create_table :organisations do |t|
      t.string :org_name
      t.timestamps
    end
  end
end
