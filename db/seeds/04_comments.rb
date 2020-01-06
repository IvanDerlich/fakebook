random_posts = Post.order("RANDOM()").take(6)
random_users = User.order("RANDOM()").take(6) 

random_posts.each do |post|
  random_users.each do |user|
    user.comments_post(
      post,
      Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)
    )
  end
end

random_posts = Post.order("RANDOM()").take(6)
random_users = User.order("RANDOM()").take(6) 

random_posts.each do |post|
  random_users.each do |user|
    2.times do
      user.comments_post(
        post,
        Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)
      )
    end
  end
end

random_posts = Post.order("RANDOM()").take(6)
random_users = User.order("RANDOM()").take(6) 

random_posts.each do |post|
  random_users.each do |user|
    3.times do
      user.comments_post(
        post,
        Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)
      )
    end
  end
end