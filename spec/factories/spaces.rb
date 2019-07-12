FactoryBot.define do
  factory :space do
    departure { Faker::Address.city }
    destination { Faker::Address.city }
    departure_time { "2019-07-09 13:52:19" }
    arrival_time { "2019-07-09 13:52:19" }
  end
end
