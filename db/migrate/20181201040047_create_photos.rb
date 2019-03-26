class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.attachment :image
      t.references :album, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
