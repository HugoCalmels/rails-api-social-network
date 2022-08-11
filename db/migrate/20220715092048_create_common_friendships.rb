class CreateCommonFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :common_friendships do |t|
      t.belongs_to :owner, null: false# remove,foreign_key:true
      t.timestamps
    end
  end
end
