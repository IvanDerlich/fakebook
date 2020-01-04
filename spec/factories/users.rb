require 'factory_bot'
FactoryBot.define do

  factory :random_user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    phone_number {Faker::PhoneNumber.phone_number}
    password {Faker::Lorem.characters(number: 10)}
  end 

end
  