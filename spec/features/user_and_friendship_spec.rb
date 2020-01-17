# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do
  RSpec.configure do |c|
    c.include UserAndFrienshipHelpers
  end

  let(:sender) { FactoryBot.create(:random_user, first_name: 'sender') }
  let(:receiver) { FactoryBot.create(:random_user, first_name: 'receiver') }
  let(:receiver_user_list) { FactoryBot.create_list(:random_user, 2) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user, 2) }

  scenario '# one to one friending process' do
    checkstate(state = {
                 sender: sender, receiver: receiver,
                 request_sent_to_receiver: false,
                 are_friends: false,
                 sent_requests: 0,
                 received_requests: 0,
                 sender_friends: 0,
                 receiver_friends: 0
               })

    sender.requests_friendship(receiver)
    checkstate(state.merge!(
                 request_sent_to_receiver: true,
                 sent_requests: 1,
                 received_requests: 1
               ))

    #               byebug
    receiver.confirms_friendship(sender)
    checkstate(state.merge!(
                 request_sent_to_receiver: false,
                 are_friends: true,
                 sent_requests: 0,
                 received_requests: 0,
                 sender_friends: 1,
                 receiver_friends: 1
               ))
  end

  scenario '# Invalid friend request: user sends a request to itself' do
    sender.requests_friendship(sender)
    error = sender.errors.messages[:not_to_itself][0][0]
    expect(error).to eq('# You cannot send friend requests to yourself')
  end

  scenario '# Invalid friend request: Already sent' do
    sender.requests_friendship(receiver)
    sender.requests_friendship(receiver)
    error = sender.errors.messages[:already_sent][0][0]
    expect(error).to eq('# You have already sent a friend request to that user')
  end

  scenario '# Invalid friend request: Already received' do
    receiver.requests_friendship(sender)
    sender.requests_friendship(receiver)
    error = sender.errors.messages[:already_received][0][0]
    expect(error).to eq('# You have already received a friend request from that user')
  end

  scenario '# Invalid friend request: Already friends' do
    sender.requests_friendship(receiver)
    receiver.confirms_friendship(sender)
    sender.requests_friendship(receiver)
    error = sender.errors.messages[:already_friends][0][0]
    expect(error).to eq('# You are already a friend of that user')
  end

  scenario '# user sends a request to 2 other users' do
    checkstate(state = {
                 sender: sender, sent_requests: 0, sender_friends: 0
               })

    sender.requests_friendship(receiver_user_list[0])

    checkstate(state.merge!(
                 receiver: receiver_user_list[0], request_sent_to_receiver: true,
                 are_friends: false, sent_requests: 1, received_requests: 1,
                 receiver_friends: 0
               ))

    sender.requests_friendship(receiver_user_list[1])

    checkstate(state.merge!(
                 receiver: receiver_user_list[1], sent_requests: 2
               ))

    receiver_user_list[0].confirms_friendship(sender)
    checkstate(state.merge!(
                 receiver: receiver_user_list[0], request_sent_to_receiver: false,
                 are_friends: true, sent_requests: 1, received_requests: 0,
                 sender_friends: 1, receiver_friends: 1
               ))

    receiver_user_list[1].confirms_friendship(sender)
    checkstate(state.merge!(
                 receiver: receiver_user_list[1],
                 sent_requests: 0, sender_friends: 2
               ))
  end

  scenario '# user receives requests from 2 different users' do
    checkstate(state = {
                 receiver: receiver, received_requests: 0, receiver_friends: 0
               })

    sender_user_list[0].requests_friendship(receiver)
    checkstate(state.merge!(
                 sender: sender_user_list[0], sender_friends: 0, sent_requests: 1,
                 request_sent_to_receiver: true, are_friends: false,
                 received_requests: 1
               ))

    sender_user_list[1].requests_friendship(receiver)
    checkstate(state.merge!(
                 sender: sender_user_list[1], received_requests: 2
               ))

    receiver.confirms_friendship(sender_user_list[0])
    checkstate(state.merge!(
                 sender: sender_user_list[0], request_sent_to_receiver: false,
                 are_friends: true, sent_requests: 0,
                 received_requests: 1, sender_friends: 1,
                 receiver_friends: 1
               ))

    receiver.confirms_friendship(sender_user_list[1])
    checkstate(state.merge!(
                 sender: sender_user_list[1], received_requests: 0, receiver_friends: 2
               ))
  end
end
