FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user
    post

    factory :invalid_comment do
      content { "" }
      # post_id { }
    end
  end
end
