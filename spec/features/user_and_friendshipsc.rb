# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User-Friendship', type: :feature do

  # create a sender user from factory
  # create a receiver user from factory
  # create a list of 5 users from factory -> receiver list
  # create a list of 5 users from factory -> sender list

  pending "# users sends a request to another user" do
    # sender asserts 0 friendships
    # sender sends request to receiver

    # sender asserts one unconfirmed friendship using a user method from the model
    # receiver asserts one unconfirmed friendship using a user method from the model
    
    # receiver confirms the request
    
    # sender asserts one confirmed friendship using a user method from the model
    # receiver asserts one confirmed friendship using a user method from the model
  end

  pending "# user sends a request to 5 other users" do
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

  pending "# user receives requests from 5 different users" do
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

  pending "# user sends invalid request to itself" do

  end

  pending "# user sends invalid request twice to another user" do
    
  end

end