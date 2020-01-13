# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { FactoryBot.create(:confirmed_friendship) }
  let(:sender) { FactoryBot.create(:random_user) }
  let(:receiver) { FactoryBot.create(:random_user) }

  it '# creates a valid unconfirmed_friendship' do
    # byebug
    unconfirmed_friendship = Friendship.new(user_id: sender.id, friend_id: receiver.id)
    expect(unconfirmed_friendship).to be_valid
  end

  it '# creates a valid confirmed_friendship' do
    confirmed_friendship = Friendship.new(user_id: sender.id, friend_id: receiver.id)
    confirmed_friendship.confirmed = true
    expect(confirmed_friendship).to be_valid
  end

  it '# invalid friendship everything ok but with no sender(user)' do
    friendship.user = nil
    expect(friendship).to_not be_valid
  end

  it '# invalid friendship everything ok but with no receiver(friend)' do
    friendship.friend = nil
    expect(friendship).to_not be_valid
  end

  it '# invalid friendship everything ok but with nil confirmation property' do
    friendship.confirmed = nil
    expect(friendship).to_not be_valid
  end
end
