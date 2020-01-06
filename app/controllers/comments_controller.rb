# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    redirect_to posts_path if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
