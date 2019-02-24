FactoryBot.define do
  factory :subitem do

    description { Faker::Coffee.origin }
    name { Faker::Name.name }
    level { %w[alto baixo medio].sample }

  end
end