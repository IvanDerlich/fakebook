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

  scenario "# Invalid friend request: user sends a request to itself" do       
    sender.requests_friendship(sender)
    error = sender.errors.messages[:not_to_itself][0][0]
    expect(error).to eq('# You cannot send friend requests to yourself')
  end

  scenario "# Invalid friend request: Already sent" do    
    sender.requests_friendship(receiver)
    sender.requests_friendship(receiver)    
    error = sender.errors.messages[:already_sent][0][0]
    expect(error).to eq('# You have already sent a friend request to that user')
  end

  scenario "# Invalid friend request: Already received" do
    receiver.requests_friendship(sender)
    sender.requests_friendship(receiver)
    error = sender.errors.messages[:already_received][0][0]
    expect(error).to eq('# You have already received a friend request from that user')    
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
    checkstate(state) 
    

    receiver_user_list[1].confirms_friendship(sender) 
    state.merge!({
      receiver: receiver_user_list[1],
      sent_requests: 3,
      sender_friends: 2
    })

    checkstate(state)           

    receiver_user_list[2].confirms_friendship(sender)  
    state.merge!({
      receiver: receiver_user_list[2],
      sent_requests: 2,
      sender_friends: 3
    })
    
    checkstate(state)       
    
    receiver_user_list[3].confirms_friendship(sender)  
    state.merge!(
      receiver: receiver_user_list[3],
      sent_requests: 1,
      sender_friends: 4
    )
    
    checkstate(state)       

    receiver_user_list[4].confirms_friendship(sender)  
    state.merge!(
      receiver: receiver_user_list[4],
      sent_requests: 0,
      sender_friends: 5
    )
     
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
    state.merge!(
      sender: sender_user_list[0],
      request_sent_to_receiver: false,   
      are_friends: true,
      sent_requests: 0,
      received_requests: 4,
      sender_friends: 1,
      receiver_friends: 1    
    )       
    checkstate(state)    

    receiver.confirms_friendship(sender_user_list[1])   
    state.merge!(
      sender: sender_user_list[1],
      received_requests: 3,
      receiver_friends: 2
    )
    
    checkstate(state)    

    receiver.confirms_friendship(sender_user_list[2])   
    state.merge!({
      sender: sender_user_list[2],
      received_requests: 2,
      receiver_friends: 3
    })
    
    checkstate(state)  

    receiver.confirms_friendship(sender_user_list[3])   
    state.merge!({
      sender: sender_user_list[3],
      received_requests: 1,
      receiver_friends: 4
    })
    checkstate(state)  

    receiver.confirms_friendship(sender_user_list[4])   
    state.merge!({
      sender: sender_user_list[4],
      received_requests: 0,
      receiver_friends: 5
    })
    checkstate(state)  

  end
end