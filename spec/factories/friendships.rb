FactoryBot.define do

  factory :unconfirmed_friendship, class: Friendship do
    association :user, factory: :random_user     
    association :friend, factory: :random_user     
    confirmed { false }
  end

  factory :confirmed_friendship, class: Friendship do
    association :user, factory: :random_user     
    association :friend, factory: :random_user     
    confirmed { true }
  end

end
