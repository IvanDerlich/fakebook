# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def dashboard
    timeline_posts
    @comment = Comment.new
  end

  def index
    @friends = current_user.friends
    @sender_users = current_user.requests_received
    @receiver_users = current_user.requests_sent
    @rest_of_users = User.all - @friends - @sender_users - @receiver_users

    @unconfirmed_sent_friendships = current_user.requests_sent
    @requests_received = current_user.requests_received
  end

  def show
    @user = User.find(params[:id])
  end
end
