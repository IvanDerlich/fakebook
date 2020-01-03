require 'rails_helper'

RSpec.describe User, type: :model do
  it '#creates valid user from factorybot' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid with email length more than 255' do
    email = 'k' * (256 - 11)
    user = build(:user, email: "#{email}@example.com")
    user.valid?
    expect(user.errors[:email]).to include('is too long (maximum is 255 characters)')
  end

  it 'blank user is invalid' do
    user = User.new
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
    expect(user.errors[:last_name]).to include("can't be blank")
    expect(user.errors[:email]).to include("can't be blank")
    expect(user.errors[:phone_number]).to include("can't be blank")
  end

  it 'valid post association' do
    user = create(:user)
    post = user.posts.build({text: "This is a test description"})
    post.valid?
    expect(post).to be_valid
  end

  context 'with differents invalid email addresses' do
    invalid_emails = [
      'plainaddress',
      "#@%^%#{$ERROR_POSITION}#{$ERROR_POSITION}#.com",
      '@example.com',
      'Joe Smith <email@example.com>',
      'email.example.com',
      'あいうえお@example.com',
      'email@example.com (Joe Smith)',
      'email@example',
      'email@111.222.333.44444',
      'email@example..com'
    ]

    it 'is invalid with invalid email formats' do
      invalid_emails.each do |email|
        user = build(:user, email: email)
        expect(user).to_not be_valid
      end
    end
  end
end

