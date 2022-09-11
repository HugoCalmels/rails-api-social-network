# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'


##
heros = RestClient.get("https://api-images-seeder-rails.herokuapp.com/hero_images")
heros_array = JSON.parse(heros)
avatars = RestClient.get("https://api-images-seeder-rails.herokuapp.com/avatar_images")
avatars_array = JSON.parse(avatars)
posts = RestClient.get("https://api-images-seeder-rails.herokuapp.com/post_images")
posts_array = JSON.parse(posts)
## 

index3 = 0
50.times do |index|

  u = User.new(
    username: Faker::Name.unique.first_name,
    email: Faker::Internet.unique.email,
    password: "123123",
    password_confirmation: "123123",
    avatar_link: avatars_array[index]["image_link"],
    thumbnail_link: heros_array[index]["image_link"]
  )
  u.skip_confirmation!
  u.save
  10.times do |index2|
    p = Post.new(
      content: Faker::Lorem.sentence(word_count: 50),
      image_link: posts_array[index3]["image_link"] ,
      user_id: u.id,
      author: u.username,
      has_to_be_displayed: false
    )
    p.save
    index3 += 1
    puts p.errors.messages
  end

  if User.all.length > 5
  10.times do |index|
  u2 = User.all.find_by_id(rand(1..User.all.length))
  puts "%%%"
  puts u2
  if (u.friends.include?(u2) && u2.id != u.id)
  else
    friendship1 = u.friendships.build(friend_id: u2.id)
    friendship2 = u2.friendships.build(friend_id: u.id)
    friendship1.save && friendship2.save
  end
  end
end

end

u = User.new(
  username: "hugo",
  email: "hugo@yahoo.fr",
  password: "azeaze",
  password_confirmation: "azeaze"
)
u.skip_confirmation!
u.save
