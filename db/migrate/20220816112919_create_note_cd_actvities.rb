# frozen_string_literal: true

class CreateNoteCdActvities < ActiveRecord::Migration[6.1]
  def change
    create_table :note_cd_actvities do |t|
      t.references :ticket, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.references :note, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.references :activity, null: false, foreign_key: { on_delete: :cascade, on_update: :cascade }

      t.timestamps
    end
  end
end
