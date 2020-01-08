# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:random_user) }

  it 'is invalid with text length more than 300' do
    text = 'k' * 301
    post = Post.new(text: text, user_id: 1)
    post.valid?
    expect(post.errors[:text]).to include('is too long (maximum is 300 characters)')
  end

  it 'blank post is invalid' do
    post = Post.new
    post.valid?
    expect(post.errors[:text]).to include("can't be blank")
    expect(post.errors[:user_id]).to include("can't be blank")
  end

  it 'valid user association' do
    post = user.posts.build(text: 'This is a test description')
    user = post.user
    user.valid?
    expect(user).to be_valid
  end

  it 'creates a successful post' do
    post = user.posts.create(text: 'This is a valid post')
    post.valid?
    expect(post).to be_valid
  end

  it 'fails to create an invalid post' do
    post = user.posts.create(text: 'T')
    post.valid?
    expect(post).to_not be_valid
  end

  it 'is invalid with text length less than 5' do
    text = Faker::Lorem.paragraph_by_chars(number: 4, supplemental: false)
    post = Post.new(text: text, user_id: 1)
    post.valid?
    expect(post.errors[:text]).to include('is too short (minimum is 5 characters)')
  end
end
