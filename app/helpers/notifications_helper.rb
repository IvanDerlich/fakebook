# frozen_string_literal: true

module NotificationsHelper
  def friend_requests_count
    return current_user.requests_received.count if current_user.requests_received.count != 0

    0
  end
end
