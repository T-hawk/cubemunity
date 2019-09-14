require 'rails_helper'
require 'pp'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do
    before :each do 
      User.delete_all
      @attribs = FactoryGirl.attributes_for(:user)
    end
    context "with valid attributes" do
      it "create new session" do
        @user = User.new(@attribs)
        @user.save
        post :create, params: { user: @attribs }
        expect(session[:user_id]).to be_truthy
      end
    end
    context "with invalid attributes" do
      it "does not create new session" do
        @user = User.new(@attribs)
        @user.save
        post :create, params: { user: FactoryGirl.attributes_for(:invalid_user) }
        expect(session[:user_id]).to be_falsey
      end
    end
  end
end