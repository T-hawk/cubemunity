require 'rails_helper'
require 'pp'

RSpec.describe PostsController, type: :controller do
  describe "POST #new" do
    before :each do 
      Post.delete_all
      User.delete_all
    end

    
    context "with valid attributes" do
      it "create new post" do
        signed_in_user
        post :new, params: { post: FactoryGirl.attributes_for(:post) }
        expect(Post.count).to eq(1)
      end
    end

    context "with invalid attributes" do
      it "does not create new post" do
        signed_in_user
        post :new, params: { post: FactoryGirl.attributes_for(:invalid_post) }
        expect(Post.count).to eq(0)
      end
    end
  end
end
