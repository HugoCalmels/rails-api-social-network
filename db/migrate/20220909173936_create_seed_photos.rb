class CreateSeedPhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :seed_photos do |t|
      t.string :image

      t.timestamps
    end
  end
end
