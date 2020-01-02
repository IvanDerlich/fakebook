require 'factory_bot'
FactoryBot.define do
  factory :user do            
    first_name {"Ignacio"}
    last_name {"Loyola"}
    email {Faker::Internet.safe_email}
    phone_number {"5555555555"}
    password {"laralala"}      
  end

  factory :random_user, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    phone_number {"5555555555"}
    password {"qwerty"}
  end
  # Not used in this tutorial, but left to show an example of different user types
  # factory :admin do
  #   id {2}
  #   email {"test@admin.com"}
  #   password {"qwerty"}
  #   admin {true}
  # end
end
  