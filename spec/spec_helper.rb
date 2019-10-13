require 'capybara/rspec'

module LetDeclarations
  extend RSpec::SharedContext

  let(:signed_in_user) { 
    @user = User.new(FactoryGirl.attributes_for(:user))
    @user.save
    session[:user_id] = @user.id
  }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include LetDeclarations

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
