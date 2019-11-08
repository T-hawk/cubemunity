class LikesController < ApplicationController
  before_action :get_post

  def create
    if !already_liked?
      @post.likes.create(user_id: @signed_in_user.id)
    end
    redirect_to community_path(anchor: @post.id)
  end

  def get_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(user_id: @signed_in_user.id, post_id: @post.id).exists?
  end
end
