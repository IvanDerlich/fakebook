class FriendshipsController < ApplicationController
  def new
    user = User.second
    friendship = current_user.request_friendship(user)
    flash[:success] = friendship.save ? "You sent a request successfully" : "Some error while sending"
    redirect_to users_path
  end
end
