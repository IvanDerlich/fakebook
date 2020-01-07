# frozen_string_literal: true

module UsersHelper

  def friendship_pending?(friend)
   @unconfirmed_sent_friendships.include?(friend)
  end
end
