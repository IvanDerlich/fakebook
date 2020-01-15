# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Comments-Post', type: :feature do
  let(:post) { FactoryBot.create(:random_post) }
  let(:user) { FactoryBot.create(:random_user) }
  let(:users) { FactoryBot.create_list(:random_user, 5) }
  let(:posts) { FactoryBot.create_list(:random_post, 5) }

  scenario '# user comments one post' do
    comment = user.comments_post(
      post,
      Faker::Lorem.paragraph_by_chars(number: 40, supplemental: false)
    )
    expect(comment).to be_valid
  end

  scenario '# user comments 5 different posts' do
    posts.each do |item|
      comment = user.comments_post item, Faker::Lorem.paragraph_by_chars(number: 20, supplemental: false)
      expect(comment).to be_valid
    end
  end

  scenario '# post gets 5 comments from 5 different users' do
    users.each do |item|
      comment = item.comments_post post, Faker::Lorem.paragraph_by_chars(number: 20, supplemental: false)
      expect(comment).to be_valid
    end
  end

  scenario '# post gets 5 comments from one user' do
    5.times do
      comment = user.comments_post post, Faker::Lorem.paragraph_by_chars(number: 20, supplemental: false)
      expect(comment).to be_valid
    end
  end
end
