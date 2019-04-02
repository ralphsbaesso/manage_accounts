FactoryBot.define do
  factory :task do
    description { Faker::Coffee.origin }
    name { Faker::Name.name }
    done { [true, false].sample }
    due_date { Date.today }
  end
end