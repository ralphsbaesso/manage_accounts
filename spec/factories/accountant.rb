FactoryBot.define do

  factory :accountant do
    name { Faker::FunnyName.name }
    email { Faker::Internet.email }
    password { '123456' }

  end

end