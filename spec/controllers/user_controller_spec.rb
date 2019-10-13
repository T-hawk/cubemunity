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

    context "with invalid attributes" do
      it "does not create new user" do
        post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }
        expect(User.count).to eq(0)
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