class PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.build(post_params)

    if post.save
      flash[:success] = "Post created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:text)
  end
end
