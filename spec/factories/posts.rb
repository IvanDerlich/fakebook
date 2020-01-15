# frozen_string_literal: true

require 'factory_bot'
FactoryBot.define do
  factory :random_post, class: Post do
    text { Faker::Lorem.paragraph_by_chars(number: 30, supplemental: false) }
    association :user, factory: :random_user
  end
end
