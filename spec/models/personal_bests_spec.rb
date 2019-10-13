require 'rails_helper'

RSpec.describe PersonalBests, type: :model do
  let(:personal_bests) { FactoryGirl.create(:personal_bests) }

  it "has a valid factory" do
    expect(personal_bests).to be_valid
  end
end
