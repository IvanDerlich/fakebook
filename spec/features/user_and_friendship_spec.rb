# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do

  let(:sender){ FactoryBot.create(:random_user, first_name: 'sender')}
  let(:receiver){ FactoryBot.create(:random_user, first_name: 'receiver')}
  let(:receiver_user_list) { FactoryBot.create_list(:random_user,5) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user,5) }  

  scenario "# user with no friendship activity" do     
    
    expect(sender.friends.first).to eq(nil) 
    expect(receiver.friends.first).to eq(nil)  

    expect(sender.requests_sent_users.first).to eq(nil)
    expect(receiver.requests_sent_users.first).to eq(nil)

    expect(sender.requests_received_users.first).to eq(nil)
    expect(receiver.requests_received_users.first).to eq(nil)

  end

  scenario '# users sends a request to another user' do
    friendship = sender.requests_friendship(receiver) 

    expect(friendship.user).to eq(sender)
    expect(friendship.friend).to eq(receiver)
    expect(friendship.confirmed).to eq(false)

    expect(sender.friends.first).to eq(nil) 
    expect(receiver.friends.first).to eq(nil)  

    expect(sender.requests_sent_users.first).to eq(receiver)
    expect(receiver.requests_sent_users.first).to eq(nil)

    expect(sender.requests_received_users.first).to eq(nil)
    expect(receiver.requests_received_users.first).to eq(sender)  
    
    
  end

  scenario '# user confirms friendship succesfully' do
    friendship = sender.requests_friendship(receiver) 
    
    receiver.confirms_friendship(friendship)
    
    expect(sender.friends.first).to eq(receiver) 
    expect(receiver.friends.first).to eq(sender)  

    expect(sender.requests_sent_users.first).to eq(nil)
    expect(receiver.requests_sent_users.first).to eq(nil)

    expect(sender.requests_received_users.first).to eq(nil)
    expect(receiver.requests_received_users.first).to eq(nil)
  end

  #<comment> send this funtion to a helper method
  # this to replace parameters for a hash
  def checkstate(sender,
    receiver,are_friends, 
    sent_requests, 
    received_requests, 
    ender_friends, 
    receiver_friends
  )    
    expect(sender.friend?(receiver)).to be(are_friends)
    expect(receiver.friend?(sender)).to be(are_friends)

    expect(sender.requests_sent_users.length).to eq(sent_requests)
    expect(receiver.requests_received_users.length).to eq(received_requests)    

    expect(sender.friends.length).to eq(sender_friends)
    expect(receiver.friends.length).to eq(receiver_friends)
    
  end
  #</comment>

  scenario "# user sends a request to 5 other users" do
    
    expect(sender.requests_sent_users.length).to eq(0)
    
    sender.requests_friendship(receiver_user_list[0])
    checkstate( sender, receiver_user_list[0], 
      false, # are friends?
      1, # sender's friend_requests
      1, # receiver's received requests
      0, # sender's friends
      0 # receiver's friends
    ) 

    sender.requests_friendship(receiver_user_list[1])
    checkstate( sender, receiver_user_list[1], 
      false, # are friends?
      2, # sender's friend_requests
      1, # receiver's received requests
      0, # sender's friends
      0 # receiver's friends
    )   

    sender.requests_friendship(receiver_user_list[2])
    checkstate( sender, receiver_user_list[2], 
      false,# are friends?
      3, # sender's friend_requests
      1, # receiver's received requests
      0, # sender's friends
      0 # receiver's friends
    )  
    

    sender.requests_friendship(receiver_user_list[3])
    checkstate( sender, receiver_user_list[3], 
      false, # are friends?
      4, # sender's friend_requests
      1, # receiver's received requests
      0, # sender's friends
      0 # receiver's friends
    )
    
    sender.requests_friendship(receiver_user_list[4])
    checkstate( sender, receiver_user_list[4], 
      false, # are friends?
      5, # sender's friend_requests
      1, # receiver's received requests
      0, # sender's friends
      0 # receiver's friends
    )  
    

    receiver_user_list[0].confirms_friendship_user(sender)  
    checkstate( sender, receiver_user_list[0],
       true, # are friends?
       4, # sender's friend_requests
       0, # receiver's received requests
       1, # sender's friends
       1 # receiver's friends
      )
    receiver_user_list[1].confirms_friendship_user(sender)  
    checkstate( sender, receiver_user_list[1],
       true, #are friends?
       3, # sender's friend_requests
       0, # receiver's received requests
       2, # sender's friends
       1 # receiver's friends
      )

    receiver_user_list[2].confirms_friendship_user(sender)  
    checkstate( sender, receiver_user_list[1],
       true, #are friends?
       2, # sender's friend_requests
       0, # receiver's received requests
       3, # sender's friends
       1 # receiver's friends
      )

    receiver_user_list[3].confirms_friendship_user(sender)  
    checkstate( sender, receiver_user_list[1],
       true, #are friends?
       1, # sender's friend_requests
       0, # receiver's received requests
       4, # sender's friends
       1 # receiver's friends
      )
    receiver_user_list[4].confirms_friendship_user(sender)  
    checkstate( sender, receiver_user_list[1],
      true, #are friends?
      0, # sender's friend_requests
      0, # receiver's received requests
      5, # sender's friends
      1 # receiver's friends
    )
    
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