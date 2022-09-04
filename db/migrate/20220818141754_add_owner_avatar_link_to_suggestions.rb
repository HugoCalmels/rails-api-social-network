class AddOwnerAvatarLinkToSuggestions < ActiveRecord::Migration[6.1]
  def change
    add_column :suggestions, :owner_avatar_link, :text
  end
end
