class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments
  has_many :likes

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
