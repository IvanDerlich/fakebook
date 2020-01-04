# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

user = User.create(    
    first_name: 'Pablo',
    last_name: 'Ortega',
    email: 'pablo_ortega@example.com',
    phone_number: '2223232',
    password: 'foobar',
    password_confirmation: 'foobar'
)

user.posts.create!(
  text: "This is my first post"
)

49.times do |n|      
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
  
#<comment> make those 6 users random: random_users_1
users = User.order(:created_at).take(6) 
#https://hashrocket.com/blog/posts/rails-quick-tips-random-records
#</comment>
  
50.times do
    users.each do |u|
        u.posts.create!(
        text: Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)        
        )
    end
end

#------

#grab 6 random posts (random_posts_1)

#comment them once with random_users_1 and random_posts_1

#------

#grab 6 random posts (random_posts_2)
#grab 6 random users (random_users_2)

#comment them twice with random_post_2 and random_users_2

#------

#grab 6 random posts (random_posts_3)
#grab 6 random users (random_users_3)

#like them once with random_users_3 and random_posts_3

#------

#grab 6 random posts (random_posts_4)
#grab 6 random users (random_users_4)

#comment them twice with random_post_4 and random_users_4
#------

#make this seed file multiple files by creating a seed folder and including every file in this files


