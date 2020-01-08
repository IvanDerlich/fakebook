class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  
  def new
    friend = User.find_by(id: params[:user])
    friendship = current_user.requests_friendship(friend)
    flash[:success] = friendship.save ? "You sent a request successfully" : "Some error while sending"
    redirect_to users_path
  end
end