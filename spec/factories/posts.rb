FactoryGirl.define do
  factory :post do
    title { "Valid title" }
    content { Faker::Lorem.paragraph }
    user
    
    factory :invalid_post do
      title { Faker::Lorem.characters }
      content { "" }
      # user
    end
  end
end
