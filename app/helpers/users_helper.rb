# frozen_string_literal: true

module UsersHelper

  def friendship_requested_pending?(friend)
    @unconfirmed_sent_friendships.include?(friend)
    # return confirm friendship, pending or request friendship, also Friends as a text
  end

  def friendship_unconfirmed?(friend)
    @requests_received.include?(friend)
  end
end
