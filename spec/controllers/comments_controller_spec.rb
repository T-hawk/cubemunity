require 'rails_helper'
require 'pp'

RSpec.describe CommentsController, type: :controller do
  describe "COMMENT #new" do
    before :each do
      User.delete_all
      Post.delete_all
      Comment.delete_all
    end

    context "with valid attributes" do
      it "creates new comment" do
        signed_in_user
        @post = @user.posts.create(FactoryGirl.attributes_for(:post))
        @post.save

        post :new, params: { comment: FactoryGirl.attributes_for(:comment), post_id: @post.id }
        expect(Comment.count).to eq(1)
      end
    end

    context "with invalid attributes" do
      it "does not creates new comment" do
        signed_in_user
        @post = @user.posts.create(FactoryGirl.attributes_for(:post))
        @post.save

        post :new, params: { comment: FactoryGirl.attributes_for(:invalid_comment), :post_id => @post.id }
        expect(Comment.count).to eq(0)
      end
    end
  end
end