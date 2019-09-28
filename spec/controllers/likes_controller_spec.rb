require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  describe "POST #create" do
    before :each do
      Like.delete_all
      User.delete_all
      Post.delete_all
    end

    context "with valid attributes" do
      it "creates a like" do
        @user = User.new(FactoryGirl.attributes_for(:user))
        @user.save
        session[:user_id] = @user.id
        @post = @user.posts.create(FactoryGirl.attributes_for(:post))
        @post.save
        post :create, params: { post_id: @post.id }

        expect(Like.count).to eq(1)
      end
    end

    context "already liked post" do
      it "does not create a like" do
        @user = User.new(FactoryGirl.attributes_for(:user))
        @user.save
        session[:user_id] = @user.id
        @post = @user.posts.create(FactoryGirl.attributes_for(:post))
        @post.save
        post :create, params: { post_id: @post.id }
        expect(Like.count).to eq(1)
        post :create, params: { post_id: @post.id }
        expect(Like.count).to eq(1)
      end
    end
  end
end
