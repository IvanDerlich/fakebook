FactoryBot.define do
    factory :user do
      id {}            
      first_name {"Ignacio"}
      last_name {"Loyola"}
      email {"psdfgfh@example.com"}
      phone_number {"0303456"}
      password {"laralala"}      
    end
  
    # Not used in this tutorial, but left to show an example of different user types
    # factory :admin do
    #   id {2}
    #   email {"test@admin.com"}
    #   password {"qwerty"}
    #   admin {true}
    # end
  end
  