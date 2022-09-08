class CommonFriendship < ApplicationRecord
  has_many :asso_friendships
  has_many :users, through: :asso_friendships, dependent: :destroy
  belongs_to :owner, :class_name => "User"

end
