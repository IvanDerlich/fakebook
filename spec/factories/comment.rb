require 'factory_bot'
FactoryBot.define do

  factory :comment, class: Comment do
    text { Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false) }  
    association :user, factory: :user    
    association :post, factory: :post
  end
  
end
  