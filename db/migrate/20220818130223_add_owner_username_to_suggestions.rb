class AddOwnerUsernameToSuggestions < ActiveRecord::Migration[6.1]
  def change
    add_column :suggestions, :owner_username, :string
  end
end
