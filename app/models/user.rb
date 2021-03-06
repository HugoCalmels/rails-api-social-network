class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable,
  :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :posts
  has_many :comments
  has_many :likes
end