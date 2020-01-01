require 'rails_helper'

RSpec.describe Post, type: :model do
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
    user = create(:user)
    post = user.posts.build({text: "This is a test description"})
    user = post.user
    user.valid?
    expect(user).to be_valid
  end
end
