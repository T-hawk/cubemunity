class ApplicationController < ActionController::Base
  before_action :set_user

  def set_user
    @signed_in_user = User.find_by(remember_digest: cookies[:remember_token]) if cookies[:remember_token]
    if @signed_in_user
      session[:user_id] = @signed_in_user.id
    elsif User.exists?(session[:user_id])
      @signed_in_user = User.find(session[:user_id])
    end
  end
end
