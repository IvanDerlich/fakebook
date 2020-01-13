module User_and_Frienship_helpers
  def checkstate(state)  
    
    if state[:sender]    
      state[:sender].reload   
      expect(state[:sender].requests_sent.length).to eq(state[:sent_requests])
      expect(state[:sender].friends.length).to eq(state[:sender_friends])
    end
    
    if state[:receiver]    
      state[:receiver].reload 
      expect(state[:receiver].requests_received.length).to eq(state[:received_requests])
      expect(state[:receiver].friends.length).to eq(state[:receiver_friends]) 
    end    

    friendship = Friendship.find{|f| 
      f.user == state[:sender] and f.friend == state[:receiver]
    }  
    if state[:request_sent_to_receiver]  
      state[:sender].reload
      state[:receiver].reload 
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
    elsif state[:are_friends]
      expect(friendship).to_not eq(nil)
      expect(state[:sender].friend?(state[:receiver])).to be(state[:are_friends])
      expect(state[:receiver].friend?(state[:sender])).to be(state[:are_friends])
    else
      expect(friendship).to eq(nil)
    end   
  end
end