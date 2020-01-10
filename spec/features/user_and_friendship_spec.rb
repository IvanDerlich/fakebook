# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do

  let(:sender){ FactoryBot.create(:random_user, first_name: 'sender')}
  let(:receiver){ FactoryBot.create(:random_user, first_name: 'receiver')}
  let(:receiver_user_list) { FactoryBot.create_list(:random_user,5) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user,5) }  


  def checkstate(state)  
    state[:sender].reload if state[:sender]
    state[:receiver].reload if state[:receiver]
    expect(state[:sender].friend?(state[:receiver])).to be(state[:are_friends]) if state[:are_friends] && state[:sender] && state[:receiver]
    expect(state[:receiver].friend?(state[:sender])).to be(state[:are_friends]) if state[:are_friends] && state[:sender] && state[:receiver]

    expect(state[:sender].requests_sent.length).to eq(state[:sent_requests]) if state[:sent_requests] && state[:sender]    
    
    expect(state[:receiver].requests_received.length).to eq(state[:received_requests]) if state[:received_requests] && state[:receiver]

    expect(state[:sender].friends.length).to eq(state[:sender_friends]) if state[:sender_friends] && state[:sender]
    expect(state[:receiver].friends.length).to eq(state[:receiver_friends]) if state[:receiver_friends]  && state[:receiver]
   
    if state[:request_sent_to_receiver]  
      expect(state[:sender].requests_sent.include?(state[:receiver])).to eq(true)
      expect(state[:receiver].requests_received.include?(state[:sender])).to eq(true)        
      friendship = Friendship.find{|f| 
        f.user == state[:sender] and f.friend == state[:receiver]
      }
      #byebug
      expect(friendship).to_not eq(nil)
      expect(friendship.user).to eq(state[:sender])
      expect(friendship.friend).to eq(state[:receiver])
      if state[:are_friends]  
        expect(friendship.confirmed).to be(true) 
        expect(state[:sender].friends.include?(state[:receiver])).to eq(true)
        expect(state[:receiver].friends.include?(state[:sender])).to eq(true)        
      else 
        expect(friendship.confirmed).to be(false) 
        expect(state[:sender].friends.include?(state[:receiver])).to eq(false)
        expect(state[:receiver].friends.include?(state[:sender])).to eq(false)
      end
    else   
      friendship = Friendship.find{|f| 
        f.user == state[:sender] and f.friend == state[:receiver]
      }
      expect(friendship).to eq(nil)
    end     

    
  end

  scenario "# user with no friendship activity" do 
    state = {
      sender: sender,
      receiver: receiver,
      request_sent_to_receiver: false,
      are_friends: false,            
      sent_requests: 0,  
      received_requests: 0,    
      sender_friends:  0,  
      receiver_friends: 0    
    }   
    checkstate(state) 

    sender.requests_friendship(receiver)     
    state[:request_sent_to_receiver] = true
    state[:sent_requests] = 1
    state[:received_requests] = 1

    checkstate(state)        
    
    receiver.confirms_friendship(sender)        
    state = {   
      are_friends: true,            
      sent_requests: 0,  
      received_requests: 0,    
      sender_friends:  1,  
      receiver_friends: 1    
    }   
    checkstate(state)
  end 
  

  scenario "# user sends a request to 5 other users" do    
    
    state = {
      sender: sender,            
      sent_requests: 0,      
      sender_friends:  0,      
    }        
    checkstate(state) 
    
    sender.requests_friendship(receiver_user_list[0])
    state = {      
      receiver: receiver_user_list[0],
      are_friends: false,
      sent_requests: 1,
      received_requests:  1,      
      receiver_friends: 0
    }    
    checkstate(state) 

    sender.requests_friendship(receiver_user_list[1])    
    state[:receiver] = receiver_user_list[1]
    state[:sent_requests] = 2
    checkstate(state) 

    sender.requests_friendship(receiver_user_list[2])  
    state[:receiver] = receiver_user_list[2]
    state[:sent_requests] = 3
    checkstate(state) 

    sender.requests_friendship(receiver_user_list[3])
    state[:receiver] = receiver_user_list[3]
    state[:sent_requests] = 4
    checkstate(state) 
    
    sender.requests_friendship(receiver_user_list[4])
    state[:receiver] = receiver_user_list[4]
    state[:sent_requests] = 5
    checkstate(state) 
    

    receiver_user_list[0].confirms_friendship(sender)  
    state[:receiver] = receiver_user_list[0]
    state[:are_friends] = true
    state[:sent_requests] = 4
    state[:received_requests] = 0
    state[:sender_friends] = 1
    state[:receiver_friends] = 1
    

    receiver_user_list[1].confirms_friendship(sender)  
    state[:receiver] = receiver_user_list[1]
    state[:sent_requests] = 3
    state[:sender_friends] = 2
    checkstate(state)       

    receiver_user_list[2].confirms_friendship(sender)  
    state[:receiver] = receiver_user_list[2]
    state[:sent_requests] = 2
    state[:sender_friends] = 3
    checkstate(state)       
    
    receiver_user_list[3].confirms_friendship(sender)  
    state[:receiver] = receiver_user_list[3]
    state[:sent_requests] = 1
    state[:sender_friends] = 4
    checkstate(state)       

    receiver_user_list[4].confirms_friendship(sender)  
    state[:receiver] = receiver_user_list[4]
    state[:sent_requests] = 0
    state[:sender_friends] = 5
    checkstate(state)       
    
  end

  xit "# user receives requests from 5 different users" do
    state = {
      sender: sender,            
      sent_requests: 0,      
      sender_friends:  0,      
    }        
    checkstate(state)

    sender_user_list[0].requests_friendship(receiver)
    state = {      
      receiver: receiver_user_list[0],
      are_friends: false,
      sent_requests: 1,
      received_requests:  1,      
      receiver_friends: 0
    }    
    checkstate(state) 

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

  # tests below are for the 6th milestone.

  xit "# invalid friend request: user sends a request to itself" do

  end

  xit "# invalid friend request: twice to another user" do
    
  end

  xit "# invalid friend request: user (sender) sends a friend request to another user and receiver sends a friend request to sender" do

  end

end