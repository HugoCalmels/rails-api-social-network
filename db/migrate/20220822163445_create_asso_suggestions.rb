class CreateAssoSuggestions < ActiveRecord::Migration[6.1]
  def change
    create_table :asso_suggestions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :suggestion, index: true
      t.timestamps
    end
  end
end
