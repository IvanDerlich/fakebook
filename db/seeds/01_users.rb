49.times do |n|      
  password = "foobar"

  User.create!(
      first_name:  Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "example-#{n+1}@fakebook.com" ,
      phone_number: Faker::PhoneNumber.phone_number,
      password: password,
      password_confirmation: password 
  )
end