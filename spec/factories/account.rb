FactoryBot.define do

  factory :account do
    name { Faker::Name.name }
    header_file { '' }
  end

end