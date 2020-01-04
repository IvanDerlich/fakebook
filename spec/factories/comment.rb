require 'factory_bot'
FactoryBot.define do

  factory :random_comment, class: Comment do
    text { Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false) }  
    association :user, factory: :random_user    
    association :post, factory: :random_post
  end
  
end
  