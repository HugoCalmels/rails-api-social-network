class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  #has_one_attached :image
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :post_images

  #has_many :invitations
  has_many :sent_invitations, class_name: "Invitation", foreign_key: "sender_id"
  has_many :received_invitations, class_name: "Invitation", foreign_key: "receiver_id"

  has_many :friendships, dependent: :delete_all
  has_many :friends, :through => :friendships, dependent: :delete_all

  belongs_to :common_friendships, optional: true
  has_one :common_friendships
 #has_many :friends
 #has_many :friendships
 #belongs_to :friends, :through => :friendships, :foreign_key => 'friend_id', optional: true
  #belongs_to :friend, :class_name => 'Friendship', :foreign_key => 'friend_id' , optional: true
 

end