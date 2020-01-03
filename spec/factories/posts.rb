require 'factory_bot'
FactoryBot.define do
    factory :post do            
      text {"Factory bot post"}
      association :user, factory: :random_user      
    end
end
  