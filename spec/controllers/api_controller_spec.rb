require 'rails_helper'
require 'json'
require 'pp'

RSpec.describe ApiController, type: :controller do

  describe "POST #create_session" do
    before :each do
      User.delete_all
      @user = User.new(FactoryGirl.attributes_for(:user))
      @user.save
    end

    context "With valid attributes" do
      it "renders a token" do
        post :create_session, params: { "email" => @user.email, "password" => @user.password }
        expect(response.body).to_not eq("Failure")
      end
    end

    context "With invalid attributes" do
      it "doesn't render a token" do
        post :create_session, params: { "email" => "", "password" => "" }
        expect(response.body).to eq("Failure")
      end
    end
  end

  describe "POST #create_user" do
    before :each do
      User.delete_all
    end

    context "With valid attributes" do
      it "creates new user" do
        post :create_user, params: FactoryGirl.attributes_for(:user)
        expect(User.count).to eq(1)
      end
    end

    context "With invalid attributes" do
      it "does not create new user" do
        post :create_user, params: FactoryGirl.attributes_for(:invalid_user)
        expect(User.count).to eq(0)
      end
    end
  end

  describe "POST #create_post" do
    before :each do
      User.delete_all
      Post.delete_all
      @user = User.new(FactoryGirl.attributes_for(:user))
      @user.save
      post :create_session, params: { "email" => @user.email, "password" => @user.password }
      @token = response.body
    end

    context "With valid attributes" do
      it "creates a new post" do
        post_params = FactoryGirl.attributes_for(:post)
        post_params[:token] = @token

        post :create_post, params: post_params
        expect(Post.count).to eq(1)
      end
    end

    context "With invalid attributes" do
      it "does not creates a new post" do
        post_params = FactoryGirl.attributes_for(:invalid_post)
        post_params["token"] = @token

        post :create_post, params: post_params
        expect(Post.count).to eq(0)
      end
    end

    context "With no token" do
      it "does not creates a new post" do
        post_params = FactoryGirl.attributes_for(:invalid_post)
        post_params["token"] = ""

        post :create_post, params: post_params
        expect(Post.count).to eq(0)
      end
    end
  end

  describe "GET #get_user" do
    before :each do
      User.delete_all
      Post.delete_all
      @user = User.new(FactoryGirl.attributes_for(:user))
      @user.save
      post :create_session, params: { "email" => @user.email, "password" => @user.password }
      @token = response.body
    end

    context "With valid token" do
      it "returns user" do
        get :get_user, params: { "token" => @token, user_id: @user.id }
        json = JSON.parse(response.body)
        expect(json["username"]).to eq(@user.username)
      end
    end

    context "With invalid token" do
      it "does not return user" do
        get :get_user, params: { "token" => "", user_id: @user.id }
        expect(response.body).to eq("Failure")
      end
    end
  end
end
