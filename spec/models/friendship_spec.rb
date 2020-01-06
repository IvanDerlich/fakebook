require 'rails_helper'

RSpec.describe Friendship, type: :model do  

  let(:unconfirmed_friendship) { FactoryBot.create(:unconfirmed_friendship) }
  let(:confirmed_friendship) { FactoryBot.create(:confirmed_friendship) }
  let(:friendship) { FactoryBot.create(:confirmed_friendship) }

  it '# creates a valid unconfirmed_friendship' do
      expect(unconfirmed_friendship).to be_valid
  end

  it '# creates a valid confirmed_friendship' do
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
