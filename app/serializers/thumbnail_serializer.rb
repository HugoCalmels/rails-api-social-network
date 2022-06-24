class ThumbnailSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :image, :image_url
end
