class CreateAssoFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :asso_friendships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :common_friendship, index: true
      t.timestamps
    end
  end
end
