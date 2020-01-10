module User_and_Frienship_Helpers
  def checkstate(state)  
    state[:sender].reload if state[:sender]
    state[:receiver].reload if state[:receiver]
    expect(state[:sender].friend?(state[:receiver])).to be(state[:are_friends]) if state[:are_friends] && state[:sender] && state[:receiver]
    expect(state[:receiver].friend?(state[:sender])).to be(state[:are_friends]) if state[:are_friends] && state[:sender] && state[:receiver]

    expect(state[:sender].requests_sent.length).to eq(state[:sent_requests]) if state[:sent_requests] && state[:sender]    
    
    expect(state[:receiver].requests_received.length).to eq(state[:received_requests]) if state[:received_requests] && state[:receiver]

    expect(state[:sender].friends.length).to eq(state[:sender_friends]) if state[:sender_friends] && state[:sender]
    expect(state[:receiver].friends.length).to eq(state[:receiver_friends]) if state[:receiver_friends]  && state[:receiver]

    friendship = Friendship.find{|f| 
      f.user == state[:sender] and f.friend == state[:receiver]
    }  
    if state[:request_sent_to_receiver]  
      expect(state[:sender].requests_sent.include?(state[:receiver])).to eq(true)
      expect(state[:receiver].requests_received.include?(state[:sender])).to eq(true)        
      
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
      expect(friendship).to eq(nil)
    end   
  end
end