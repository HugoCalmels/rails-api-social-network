class Suggestion < ApplicationRecord
  has_many :asso_suggestions
  has_many :users, through: :asso_suggestions, dependent: :destroy
  belongs_to :owner, :class_name => "User"


end
