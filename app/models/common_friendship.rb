class CommonFriendship < ApplicationRecord

  has_many :users, dependent: :destroy
  belongs_to :owner, :class_name => "User"
end
