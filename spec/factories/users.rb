FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :invalid_user do
      username { "" }
      email    { "" }
      password { "" }
    end
  end
end
