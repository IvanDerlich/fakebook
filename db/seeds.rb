# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(    
    first_name: 'Pablo',
    last_name: 'Ortega',
    email: 'pablo_ortega@example.com',
    phone_number: '2223232',
    password: 'foobar',
    password_confirmation: 'foobar'
)
user.posts.create!(
  text: "This is my first post",
)

99.times do |n|      
    password = "password123"

    User.create!(
        first_name:  Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "example-#{n+1}@fakebook.com" ,
        phone_number: Faker::PhoneNumber.phone_number,
        password: password,
        password_confirmation: password 
    )
  end
  
   users = User.order(:created_at).take(6)
  
  50.times do
    users.each do |u|
      u.posts.create!(
        text: Faker::Lorem.paragraph(sentence_count: 2)
      )
    end
  end