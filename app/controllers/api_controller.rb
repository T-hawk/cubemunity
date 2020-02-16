class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action  :verify_authenticity_token

  before_action :authenticate, :except => :create_session

  def get_user
    if @authenticated
      @user = User.find(params[:user_id])
      #INSECURE SHOWS PASSWORD DIGEST?
      render json: @user.to_json
    else
      render plain: "Failure"
    end
  end

  def get_user_pb
    if @authenticated
      @user = User.find(params[:user_id])
      @personal_bests = []
      @user.personal_bests.attributes.each do |key, value|
        if key != "created_at" && key != "updated_at" && key != "id" && key != "user_id" && value
          @personal_bests.push({puzzle: key, time: value})
        end
      end

      render json: @personal_bests.to_json
    else
      render plain: "Failure"
    end
  end

  def get_posts
    if @authenticated
      @posts = Post.all
      @posts = @posts.reverse

      render json: @posts.to_json
    else
      render plain: "Failure"
    end
  end

  def get_post_comments
    if @authenticated
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      @comments = @comments.reverse
      @final_comments = []
      @comments.each do |comment, index|
        @final_comments.push({comment: comment, user: comment.user, id: comment.id})
      end
      render json: @final_comments.to_json
    else
      render plain: "Failure"
    end
  end

  def create_post
    if @authenticated
      @user = User.find_by(api_token: params["token"])
      if @user
        @post = User.find_by(api_token: params["token"]).posts.create(post_params)
        if @post.save
          render plain: "Success"
        else
          render plain: "Failure"
        end
      else
        render plain: "Failure"
      end
    else
      render plain: "Failure"
    end
  end

  def create_session
    @user = User.find_by(email: params["email"].downcase)
    if @user && @user.authenticate(params["password"])
      token = (0...8).map { (65 + rand(26)).chr }.join

      @user.update_attribute(:api_token, token)
      render plain: token
    else
      render plain: "Failure"
    end
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      token = (0...8).map { (65 + rand(26)).chr }.join

      @user.update_attribute(:api_token, token)
      render plain: token
    else
      render plain: "Failure"
    end
  end

  def post_params
    params.permit(:title, :content)
  end
  
  def user_params
    params.permit("username", "email", "password", "password_confirmation")
  end

  private
    def authenticate
      if User.find_by(api_token: params[:token])
        @authenticated = true
      else
        @authenticated = false
      end
    end
end
