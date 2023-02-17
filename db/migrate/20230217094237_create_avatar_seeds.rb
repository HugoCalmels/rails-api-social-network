class CreateAvatarSeeds < ActiveRecord::Migration[6.1]
  def change
    create_table :avatar_seeds do |t|
      t.string :name
      t.string :image_path

      t.timestamps
    end
  end
end
