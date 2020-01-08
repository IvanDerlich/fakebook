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