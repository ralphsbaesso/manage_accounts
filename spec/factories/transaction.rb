FactoryBot.define do
  factory :transaction do

    amount { Faker::Number.digit}
    date_transaction { Faker::Date.backward(10) }
    description {Faker::Shakespeare.hamlet }
    origin { true}
    title { Faker::StarWars.character }
    value { Faker::Number.decimal(2) }

  end
end