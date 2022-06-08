class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :content, :image, :user_id, :image_url
end
