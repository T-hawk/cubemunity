require 'rails_helper'
require 'pp'

RSpec.describe PersonalBestsController, type: :controller do
  describe "POST #change" do
    before :each do
      User.delete_all
    end

    context "with valid time" do
      it "changes the old personal best" do
        signed_in_user
        @personal_bests = FactoryGirl.attributes_for(:personal_bests)
        @user.personal_bests[:three_by_three] = @personal_bests[:three_by_three]

        @new_pb = FactoryGirl.attributes_for(:personal_bests)[:three_by_three]
        post :change, params: { :puzzle_name => "three_by_three", :personal_best => @new_pb }

        expect(@new_pb).to eq(User.find(session[:user_id]).personal_bests[:three_by_three])
      end

      # it "makes a new personal best" do
      #   signed_in_user
      #   post :change, params: { puzzle_name: "three_by_three", personal_best: FactoryGirl.attributes_for(:personal_bests)[:three_by_three] }
      # end
    end
  end
end