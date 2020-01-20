# frozen_string_literal: true

module UserAndFrienshipHelpers
  def checkstate(state)
    sender_check(state) if state[:sender]
    receiver_check(state) if state[:receiver]

    friendship = Friendship.find do |f|
      (f.user == state[:sender]) && (f.friend == state[:receiver])
    end
    if state[:request_sent_to_receiver]
      request_sent_to_receiver(state, friendship)
    elsif state[:are_friends]
      expect(friendship).to_not eq(nil)
      expect(state[:sender].friend?(state[:receiver])).to be(state[:are_friends])
      expect(state[:receiver].friend?(state[:sender])).to be(state[:are_friends])
    else
      expect(friendship).to eq(nil)
    end
  end

  def sender_check(state)
    state[:sender].reload
    expect(state[:sender].requests_sent.length).to eq(state[:sent_requests])
    expect(state[:sender].friends.length).to eq(state[:sender_friends])
  end

  def receiver_check(state)
    state[:receiver].reload
    expect(state[:receiver].requests_received.length).to eq(state[:received_requests])
    expect(state[:receiver].friends.length).to eq(state[:receiver_friends])
  end

  def request_sent_to_receiver(state, friendship)
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
  end
end
