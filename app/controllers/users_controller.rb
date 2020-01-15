# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]

  def dashboard
    @posts = current_user.posts.order('created_at desc')
    @comment = Comment.new
  end

  def index
    @users = User.all
    @unconfirmed_sent_friendships = current_user.requests_sent
    @requests_received = current_user.requests_received
  end
end
