class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.references :client, foreign_key: true, on_delete: :cascade
      t.datetime :data

      t.timestamps
    end
  end
end
