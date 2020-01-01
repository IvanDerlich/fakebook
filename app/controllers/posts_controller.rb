# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]
  def index
    @posts = Post.all.order('created_at desc')
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
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
