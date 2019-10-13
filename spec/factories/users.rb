FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }

    # factory :personal_best do
    #   personal_best { "#{Faker::Number.between(1, 99)}:#{Faker::Number.between(1, 99)}:#{Faker::Number.between(1, 99)}" }
    # end

    factory :invalid_user do
      username { "" }
      email    { "" }
      password { "" }
    end
  end
end
