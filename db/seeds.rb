# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "steventang",
             email: "steven@example.com",
             password: "foobar",
             admin: true)

99.times do |n|
  username = Faker::Internet.user_name(Faker::Name.name, %w(- _))
  email = "example-#{n}@example.com"
  password = "password"
  User.create!(username: username,
               email: email,
               password: password)
end

users = User.order(:created_at).take(15)
10.times do
	title = Faker::Lorem.word
  content = Faker::Lorem.sentence(50)
  tag_list = ["League of Legends", "DotA", "Starcraft"].sample
  users.each { |user| user.posts.create!(title: title, text_content: content. tag_list: tag_list) }
end