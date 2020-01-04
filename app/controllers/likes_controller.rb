class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[new]
  before_action :get_post

  def new
    @like = @post.likes.build
    @like.user_id = current_user.id
    
    if @like.save
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  private

  def get_post
    @post = Post.find(params[:post_id])
  end
end
