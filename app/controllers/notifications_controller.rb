# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @received_requests = current_user.requests_received
    @sent_requests = current_user.requests_sent
  end
end
