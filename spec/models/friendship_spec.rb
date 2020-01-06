require 'rails_helper'

RSpec.describe Friendship, type: :model do  

  let(:unconfirmed_frienship) { FactoryBot.create(:unconfirmed_frienship) }
  let(:confirmed_frienship) { FactoryBot.create(:confirmed_frienship) }

  it '# creates a valid unconfirmed_friendship' do
      expect(unconfirmed_friendship).to be_valid
  end

  it '# creates a valid confirmed_friendship' do
    expect(confirmed_friendship).to be_valid
  end

<<<<<<< HEAD
  xit '# invalid like that belongs to user but not to a post' do
      like.post = nil
      expect(like).to_not be_valid
  end

  xit '# invalid like that belongs to post but not to a user ' do
      like.user = nil
      expect(like).to_not be_valid
=======
  xit "# see all requests sent" do
    
  end
  xit "# see all requests received" do
    
  end

  xit "# see all requests sent and requests received" do
  end 

  # 6th milestone
  xit "# user sends invalid request to itself" do
  end

  xit "# user sends invalid request twice to another user" do
>>>>>>> refs/remotes/origin/5th-milestone-friendships-v1
  end

  xit '# invalid like that neither has a post nor a user ' do
      like.post = like.user = nil
      expect(like).to_not be_valid
  end  

end
