FactoryGirl.define do
  factory :client do
    name { Faker::Name.name }
    sex { Faker::Boolean.boolean }
    id_number { "ID#{Faker::Number.number(7)}" }
    phone { "+#{Faker::Number.number(3)}(#{Faker::Number.number(2)})#{Faker::Number.number(7)}" }
    address { Faker::Address.city + Faker::Address.street_address }
  end
end
