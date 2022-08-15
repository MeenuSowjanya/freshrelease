class CreateActivityModels < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_models do |t|
      t.string :model

      t.timestamps
    end
  end
end
