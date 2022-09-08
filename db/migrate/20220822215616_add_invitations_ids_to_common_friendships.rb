class AddInvitationsIdsToCommonFriendships < ActiveRecord::Migration[6.1]
  def change
    add_column :common_friendships, :invitation, :text
  end
end
