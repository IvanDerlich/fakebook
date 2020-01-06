# frozen_string_literal: true

module UsersHelper

  def some_text(friendships, friend)
    message = nil
    friendships.each do |f|
      p f
    end
    if friendships.include?(friend)
      index = friendships.index(friend)
      message = friendships[index].confirmed ? "Friends" : "Pending"
      p "entro al if"
    else
      p "entro al else"
      message = "Send Friendship Request"
    end
    return "send"
  end
end
