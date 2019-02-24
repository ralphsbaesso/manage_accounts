FactoryBot.define do
  factory :item do

    description { Faker::Coffee.origin }
    name { Faker::Name.name }

  end
end
