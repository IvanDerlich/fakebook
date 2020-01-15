# frozen_string_literal: true

module NotificationsHelper
  def friend_requests_count 
    if current_user.requests_received.count != 0
      return current_user.requests_received.count
    end    
    0
  end
end
