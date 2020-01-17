# 1 user likes 15 posts
users_pool = User.order("RANDOM()")
random_posts = Post.order("RANDOM()").take(15)
user = users_pool[0]

random_posts.each do |post|  
  user.likes_post(post)
end


# a second user likes 10 of the previous 15 posts
random_posts = random_posts.take(10)
user = users_pool[1]

random_posts.each do |post|
  user.likes_post(post)
end

# a third user likes 5 of the previos 10 posts
random_posts = Post.order("RANDOM()").take(5)
user = users_pool[2]

random_posts.each do |post|
  user.likes_post(post)
end