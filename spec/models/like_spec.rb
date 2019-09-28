require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { FactoryGirl.create(:like) }

  it "has a valid factory" do
    expect(like).to be_valid
  end

  describe Like do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
