# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

### Erase previous table
City.destroy_all
User.destroy_all
PrivateMessage.destroy_all
Gossip.destroy_all
Tag.destroy_all
JoinGossipTag.destroy_all
JoinMessageRecepient.destroy_all

### Create 10 cities
10.times do
  City.create(name: Faker::Address.city, zip_code: Faker::Number.number(digits: 5).to_s)
end

### Create 10 users
10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: "Generated description ##{Faker::Number.number(digits: 5)}",
 email: "email_#{Faker::Number.number(digits: 4)}@mail.com", age: rand(12..65), city: City.all.sample)
end

### Create 50 private messages
50.times do
  rec = User.all.sample
  sen = rec
  while sen == rec
    sen = User.all.sample
  end
  PrivateMessage.create(sender: sen)
end

### Join messages to several reveivers
50.times do
  message = PrivateMessage.all.sample
  send_user = message.sender
  reveive_user = send_user
  while reveive_user == send_user
    reveive_user = User.all.sample
  end
  JoinMessageRecepient.create(recipient: User.all.sample, private_message: message)
end

### Create 20 gossips
20.times do
  Gossip.create(title: "Gossip##{Faker::Number.number(digits: 4)}", content: Faker::Lorem.paragraph(sentence_count: 2), user: User.all.sample)
end

### Create 10 tags
10.times do
  Tag.create(title: Faker::Lorem.word)
end

### Give a tag to each gossip
Gossip.all.each do |gossip|
  JoinGossipTag.create(gossip: gossip, tag: Tag.all.sample)
end

### Provide 10 more tags randomly
10.times do
  JoinGossipTag.create(gossip: Gossip.all.sample, tag:Tag.all.sample)
end



