class CreateThumbnails < ActiveRecord::Migration[6.1]
  def change
    create_table :thumbnails do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
