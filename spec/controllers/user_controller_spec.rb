require 'rails_helper'
require 'pp'

RSpec.describe UserController, type: :controller do

  describe "POST #create" do
    before :each do
      User.delete_all
    end

    context "with valid attributes" do
      it "create new user" do
        post :create, params: { user: FactoryGirl.attributes_for(:user) }
        expect(User.count).to eq(1)
      end
    end

    context "already created user" do
      it "does not create new user" do
        attributes = FactoryGirl.attributes_for(:user)

        post :create, params: { user: attributes }
        expect(User.count).to eq(1)
        post :create, params: { user: attributes }
        expect(User.count).to eq(1)
      end
    end

    context "with invalid attributes" do
      it "does not create new user" do
        post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }
        expect(User.count).to eq(0)
      end
    end
  end

  describe "POST #follow" do
    before :each do
      User.delete_all
      Follow.delete_all
    end

    context "with valid attributes" do
      it "the user follows the other user" do
        signed_in_user
        secondary_user

        post :follow, params: { follower_id: @user.id, following_id: @other_user.id }

        expect(Follow.count).to eq(1)
        expect(@user.already_following? @other_user).to be true
      end

      it "does not follow user that is already followed" do
        signed_in_user
        secondary_user

        post :follow, params: { follower_id: @user.id, following_id: @other_user.id }
        expect(Follow.count).to eq(1)

        post :follow, params: { follower_id: @user.id, following_id: @other_user.id }
        expect(Follow.count).to eq(1)
      end

      it "unfollows user" do
        signed_in_user
        secondary_user

        post :follow, params: { follower_id: @user.id, following_id: @other_user.id }
        expect(Follow.count).to eq(1)

        post :unfollow, params: { follower_id: @user.id, following_id: @other_user.id }
        expect(Follow.count).to eq(0)
      end
    end
  end

  # describe "POST #new_pb" do
  #   it "updates personal best" do
  #     signed_in_user
  #     @personal_best = FactoryGirl.attributes_for(:personal_best)[:personal_best]
  #     post :new_pb, params: { personal_best: @personal_best }

  #     expect(@personal_best).to eq(User.find(session[:user_id]).personal_best)
  #   end
  # end
end
