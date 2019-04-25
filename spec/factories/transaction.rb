FactoryBot.define do
  factory :transaction do

    amount { Faker::Number.digit}
    date_transaction { Faker::Date.backward(10) }
    description {Faker::Lorem.sentences }
    origin { true}
    title { Faker::Book.title }
    price_cents { (0..1000000).to_a.sample }

  end
end