# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: %i[new update]

  def new
    friend = User.find_by(id: params[:user])
    friendship = current_user.requests_friendship(friend)
    flash[:success] = friendship ? 'You sent a request successfully' : 'Some error while sending'
    redirect_to users_path
  end

  def update
    friend = User.find_by(id: params[:friend_id])
    flash[:message] = current_user.confirms_friendship(friend) ? 'You became friends!' : 'Something went wrong :('
    redirect_to users_path
  end
end
