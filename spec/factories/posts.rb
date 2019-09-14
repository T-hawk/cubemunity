FactoryGirl.define do
  factory :post do
    title { "Valid title" }
    content { Faker::Lorem.paragraph }
    user_id  { 1 }
    
    factory :invalid_post do
      title { Faker::Lorem.characters }
      content { "" }
      user_id  { }
    end
  end
end
