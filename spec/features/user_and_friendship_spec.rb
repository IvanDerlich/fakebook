# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do

  let(:sender){ FactoryBot.create(:random_user, first_name: 'sender')}
  let(:receiver){ FactoryBot.create(:random_user, first_name: 'receiver')}
  let(:receiver_user_list) { FactoryBot.create_list(:random_user,5) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user,5) }  

  scenario "# user with no friendship activity" do     
    
    expect(sender.confirmed_friends.first).to eq(nil) 
    expect(receiver.confirmed_friends.first).to eq(nil)  

    expect(sender.unconfirmed_sent_friendships.first).to eq(nil)
    expect(receiver.unconfirmed_sent_friendships.first).to eq(nil)

    expect(sender.friend_requests.first).to eq(nil)
    expect(receiver.friend_requests.first).to eq(nil)

  end

  scenario '# users sends a request to another user' do
    friendship = sender.requests_friendship(receiver) 

    expect(friendship.user).to eq(sender)
    expect(friendship.friend).to eq(receiver)
    expect(friendship.confirmed).to eq(false)

    expect(sender.confirmed_friends.first).to eq(nil) 
    expect(receiver.confirmed_friends.first).to eq(nil)  

    expect(sender.unconfirmed_sent_friendships.first).to eq(receiver)
    expect(receiver.unconfirmed_sent_friendships.first).to eq(nil)

    expect(sender.friend_requests.first).to eq(nil)
    expect(receiver.friend_requests.first).to eq(sender)  
    
    
  end

  scenario '# user confirms friendship succesfully' do
    friendship = sender.requests_friendship(receiver) 
    
    receiver.confirms_friendship(friendship)
    
    expect(sender.confirmed_friends.first).to eq(receiver) 
    expect(receiver.confirmed_friends.first).to eq(sender)  

    expect(sender.unconfirmed_sent_friendships.first).to eq(nil)
    expect(receiver.unconfirmed_sent_friendships.first).to eq(nil)

    expect(sender.friend_requests.first).to eq(nil)
    expect(receiver.friend_requests.first).to eq(nil)
  end

  scenario "# user sends a request to 5 other users" do
    
    expect(sender.unconfirmed_sent_friendships.length).to eq(0)
    friendship1 = sender.requests_friendship(receiver_user_list[0])
    expect(sender.unconfirmed_sent_friendships.length).to eq(1)
    friendship2 = sender.requests_friendship(receiver_user_list[1])
    expect(sender.unconfirmed_sent_friendships.length).to eq(2)
    friendship3 = sender.requests_friendship(receiver_user_list[2])
    expect(sender.unconfirmed_sent_friendships.length).to eq(3)
    friendship4 = sender.requests_friendship(receiver_user_list[3])
    expect(sender.unconfirmed_sent_friendships.length).to eq(4)
    friendship5 = sender.requests_friendship(receiver_user_list[4])
    expect(sender.unconfirmed_sent_friendships.length).to eq(5)

    receiver_user_list[0].confirms_friendship(friendship1)  
    #expect(sender.unconfirmed_sent_friendships.length).to eq(4)
    expect(sender.friend?(receiver)).to be(true)

    expect(receiver_user_list[0].confirmed_friends.length).to eq(1)
    expect(sender.confirmed_friends.length).to eq(1)


    # sender sender.requests_friendship(receiver_user_list[1])
    # sender sender.requests_friendship(receiver_user_list[2])
    # sender sender.requests_friendship(receiver_user_list[3])
    # sender sender.requests_friendship(receiver_user_list[4])

    # sender asserts 0 unconfirmed friendships
    # sender creates 5 unconfirmed friendships
    # sender asserts 5 unconfirmed frienships    

    # receiver 1 confirms frienship
    # sender asserts 1 confirmed frienship and 4 unconfirmed

    # receiver 2 confirms friendship
    # sender asserts 2 confirmed frienships and 4 unconfirmed friendship

    #...
    
    # receiver 5 confirms friendship
    # sender asserts 5 confirmed frienships and 0 unconfirmed friendship
  end

  xit "# user receives requests from 5 different users" do
    # receivers asserts 0 unconfirmed frienships
    # receiver receives the 5 unconfirmed friendships from 5 different users
    # receiver asserts 5 unconfirmed friendships

    # receiver confirms 1 friendship
    # receiver asserts 1 confirmed and 4 unconfirmed

    # receiver confirms 1 friendship
    # receiver asserts 2 confirmed and 3 uncofirmed

    # ...

    # receiver asserts 5 confirmed and 0 unconfirmed

  end

  # tests below are for the 6th milestone

  xit "# invalid friend request: user sends a request to itself" do

  end

  xit "# invalid friend request: twice to another user" do
    
  end

  xit "# invalid friend request: user (sender) sends a friend request to another user and receiver sends a friend request to sender" do

  end

end