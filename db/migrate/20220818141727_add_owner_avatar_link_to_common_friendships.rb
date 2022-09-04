class AddOwnerAvatarLinkToCommonFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :common_friendships, :owner_avatar_link, :text
  end
end
