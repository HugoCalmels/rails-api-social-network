class AddProfileFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :avatar_link, :text
    add_column :users, :thumbnail_link, :text
    add_column :users, :last_seen, :integer
    #add_reference :users, :common_friendship, index: true
    #add_reference :users, :suggestion, index: true
    add_index :users, :username, unique: true
  end
end
