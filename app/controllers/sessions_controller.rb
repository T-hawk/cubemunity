require 'pp'

class SessionsController < ApplicationController

  def new
  #   @user = User.find_by(email: params[:user][:email])
  #   if @user && @user.authenticate(params[:user][:password])
  #     helpers.create_session_for_user(@user)
  #     redirect_to @user
  #   else
  #     redirect_to '/user/sign_in'
  #   end
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      helpers.create_session_for_user(@user)
      params[:user][:remember_me] == '1' ? helpers.remember(@user) : helpers.forget(@user)
      redirect_to @user
    else
      flash[:danger] = 'Incorrect email/password!'
      redirect_to '/user/sign_in'
    end
  end

  def destroy
    reset_session
    helpers.forget(@signed_in_user)
    redirect_to root_url
  end
end