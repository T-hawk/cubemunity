require "pp"

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

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end