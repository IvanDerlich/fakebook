# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    current_user.comments << @comment
    flash[:error] = @comment.errors.full_messages.to_sentence unless @comment.save
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
