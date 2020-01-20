# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[new]
  before_action :find_post

  def new
    @like = @post.likes.build
    @like.user_id = current_user.id

    flash[:success] = @like.save ? 'You liked this post' : 'You already liked this post'
    redirect_to posts_path
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
