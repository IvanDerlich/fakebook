# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do

  let(:sender){ FactoryBot.create(:random_user)}
  let(:receiver){ FactoryBot.create(:random_user)}
  let(:receiver_user_list) { FactoryBot.create_list(:random_user,5) }
  let(:sender_user_list) { FactoryBot.create_list(:random_user,5) }  

  scenario "# users sends a request to another user" do
    expect(sender.confirmed_sent_and_received_friendships.length).to be(0)                                                          
    expect(sender.unconfirmed_sent_and_received_friendships.length).to be(0)
    
    sender.sends_friendship_request(receiver)    

    expect(sender.unconfirmed_sent_friendships.length).to be(1)    
    expect(receiver.unconfirmed_received_friendships.length).to be(1)
    
    puts receiver.unconfirmed_received_friendships.first.class
    # receiver confirms the request
    
    # sender asserts one confirmed friendship using a user method from the model
    # receiver asserts one confirmed friendship using a user method from the model
  end

  xit "# user sends a request to 5 other users" do
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

  xit "# user sends invalid request to itself" do

  end

  xit "# user sends invalid request twice to another user" do
    
  end

end