class AssoFriendship < ApplicationRecord
  belongs_to :user
  belongs_to :common_friendship
end
