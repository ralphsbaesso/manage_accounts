FactoryBot.define do
  factory :transaction do

    amount { Faker::Number.digit}
    date_transaction { Faker::Date.backward(10) }
    description {Faker::Lorem.sentences }
    origin { true}
    title { Faker::Book.title }
    value { Faker::Number.decimal(2) }

  end
end