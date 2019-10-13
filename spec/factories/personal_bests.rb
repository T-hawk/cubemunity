FactoryGirl.define do
  factory :personal_bests do
    two_by_two { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    three_by_three { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    four_by_four { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    five_by_five { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    six_by_six { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    seven_by_seven { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    pyraminx { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    megaminx { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    clock { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    skewb { "#{Faker::Number.number(2)}:#{Faker::Number.number(2)}:#{Faker::Number.number(2)}" }
    user
  end

end
