# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @posts = current_user.posts.order('created_at desc')
  end
end
