random_users = User.order("RANDOM()").take(6) 
  
random_users.each do |u|
    10.times do
        u.posts.create!(
            text: Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)        
        )
    end
end