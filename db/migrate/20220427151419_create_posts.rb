class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.boolean :has_to_be_displayed
      t.text :image_link
      t.string :author
      t.timestamps
    end
  end
end
