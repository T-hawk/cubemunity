require "pp"
require "json"

class UserController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      helpers.create_session_for_user(@user)
      flash[:success] = 'Welcome to Cubemunity!'
      redirect_to @user
    else
      flash[:danger] = 'Could not save user'
      redirect_to '/user/new'
    end
  end

  def sign_in
    @user = User.new
  end

  def follow
    @user = User.find(params[:follower_id])
    @following_user = User.find(params[:following_id])
    already_following = false

    @following_user.followers.each do |f|
      if f.id == @user.id
        already_following = true
      end
    end

    if @user.id != @following_user.id && !(@user.already_following? @following_user)
      @relationship = @user.following_relationships.create(following_id: @following_user.id, user_id: @user.id)

      if @relationship.save
        flash[:success] = "Following user #{@following_user.username}"
        redirect_to @following_user
      else
        flash[:danger] = "Cannot follow user #{@following_user.username}"
        redirect_to @following_user
      end
    end
  end

  def unfollow
    @user = User.find(params[:follower_id])
    @following = User.find(params[:following_id])
    @follow = @following.follower_relationships.find_by(user_id: @user.id)

    if @follow.user_id == @user.id
      Follow.destroy(@follow.id)
      flash[:danger] = "Unfollowed #{@follow.following.username}"
    end

    redirect_to User.find(@follow.following_id)
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
