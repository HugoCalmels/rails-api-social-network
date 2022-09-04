class AddOwnerUsernameToCommonFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :common_friendships, :owner_username, :string
  end
end
