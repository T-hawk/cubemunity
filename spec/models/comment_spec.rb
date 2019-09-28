require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryGirl.create(:comment) }

  it "has a valid factory" do
    expect(comment).to be_valid
  end

  describe Comment do
    it { is_expected.to validate_presence_of(:content) }
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
