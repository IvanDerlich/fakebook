require 'factory_bot'
FactoryBot.define do

    factory :post do            
      text {Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false)}      
      association :user, factory: :user      
    end
    
end
  