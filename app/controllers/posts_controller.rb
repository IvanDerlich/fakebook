# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]

  def index
    @posts = current_user.posts.recent_posts
    @friends = current_user.friends
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
