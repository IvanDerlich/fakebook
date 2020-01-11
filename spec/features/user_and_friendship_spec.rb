# frozen_string_literal: true

require 'rails_helper'


RSpec.describe 'User-Friendship', type: :feature do

  RSpec.configure do |c|
    c.include User_and_Frienship_helpers
  end  

  let(:sender){ FactoryBot.create(:random_user, first_name: 'sender')}
  let(:receiver){ FactoryBot.create(:random_user, first_name: 'receiver')}
  let(:receiver_user_list) { FactoryBot.create_list(:random_user,5) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user,5) }  

  scenario "# one to one friending process" do 
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
    state.merge!({
      request_sent_to_receiver: true,
      sent_requests: 1,
      received_requests: 1
    })  
    checkstate(state)        
    
    receiver.confirms_friendship(sender)
    byebug   
    state.merge!({
      request_sent_to_receiver: false,
      are_friends: true,
      sent_requests: 0,
      received_requests: 0,
      sender_friends: 1,
      receiver_friends: 1           
    })
    checkstate(state)
  end 

  xit "# invalid friend request: user sends a request to itself" do
    
    error = sender.requests_friendship(sender)[0][0]
    
    expect(error).to eq('You cannot send friend requests to yourself')

  end

  xit "# invalid friend request: twice to the same user" do
    sender.requests_friendship(receiver)
    error = sender.requests_friendship(receiver)[0][0]
    expect(error).to eq('cannot send friend requests to yourself')
  end

  xit "# invalid friend request: user (sender) sends a friend request to another user and receiver sends a friend request to sender" do
    sender.requests_friendship(receiver)
    receiver.requests_friendship(sender)
  end
  

  scenario "# user sends a request to 5 other users" do    
    
    state = {
      sender: sender,            
      sent_requests: 0,      
      sender_friends:  0,      
    }        
    checkstate(state) 
    
    sender.requests_friendship(receiver_user_list[0])
        
    state.merge!({
      receiver: receiver_user_list[0],
      request_sent_to_receiver: true,
      are_friends: false,
      sent_requests: 1,
      received_requests:  1,
      receiver_friends: 0
    })

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
    state[:request_sent_to_receiver] = false
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

  scenario "# user receives requests from 5 different users" do
    state = {
      receiver: receiver,           
      received_requests:  0,      
      receiver_friends: 0
    }        
    checkstate(state)

    sender_user_list[0].requests_friendship(receiver)     
    state[:sender] = sender_user_list[0]
    state[:sender_friends] = 0
    state[:sent_requests] = 1
    state[:request_sent_to_receiver] = true
    state[:are_friends] = false
    state[:received_requests] = 1       
    checkstate(state) 

    sender_user_list[1].requests_friendship(receiver)     
    state[:sender] = sender_user_list[1]
    state[:received_requests] = 2       
    checkstate(state) 

    sender_user_list[2].requests_friendship(receiver)     
    state[:sender] = sender_user_list[2]
    state[:received_requests] = 3
    checkstate(state)

    sender_user_list[3].requests_friendship(receiver)     
    state[:sender] = sender_user_list[3]
    state[:received_requests] = 4
    checkstate(state)

    sender_user_list[4].requests_friendship(receiver)     
    state[:sender] = sender_user_list[4]
    state[:received_requests] = 5
    checkstate(state)

    receiver.confirms_friendship(sender_user_list[0])      
    state[:sender] = sender_user_list[0]    
    state[:request_sent_to_receiver] = false    
    state[:are_friends] = true
    state[:sent_requests] = 0
    state[:received_requests] = 4
    state[:sender_friends] = 1
    state[:receiver_friends] = 1    
    checkstate(state)    

    receiver.confirms_friendship(sender_user_list[1])   
    state[:sender] = sender_user_list[1]
    state[:received_requests] = 3
    state[:receiver_friends] = 2
    checkstate(state)    

    receiver.confirms_friendship(sender_user_list[2])   
    state[:sender] = sender_user_list[2]
    state[:received_requests] = 2
    state[:receiver_friends] = 3
    checkstate(state)  

    receiver.confirms_friendship(sender_user_list[3])   
    state[:sender] = sender_user_list[3]
    state[:received_requests] = 1
    state[:receiver_friends] = 4
    checkstate(state)  

    receiver.confirms_friendship(sender_user_list[4])   
    state[:sender] = sender_user_list[4]
    state[:received_requests] = 0
    state[:receiver_friends] = 5
    checkstate(state)  

  end
end