# frozen_string_literal: true

require 'factory_bot'
FactoryBot.define do
  factory :like, class: Like do
    association :user, factory: :random_user
    association :post, factory: :random_post
  end
end
