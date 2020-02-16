require 'json'

class PostsController < ApplicationController
  def community
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @post = @signed_in_user.posts.create(post_params)
    if @post.save
      flash[:success] = "Post successfully saved"
      redirect_to '/community'
    else
      flash[:danger] = "Post unsuccessfully saved"
      redirect_to '/community'
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
