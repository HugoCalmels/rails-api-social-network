class CreateSuggestions < ActiveRecord::Migration[6.1]
  def change
    create_table :suggestions do |t|
      t.belongs_to :owner, null: false# remove,foreign_key:true
      t.timestamps
    end
  end
end
