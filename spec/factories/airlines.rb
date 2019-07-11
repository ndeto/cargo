FactoryBot.define do
  factory :airline do
    name { Faker::Lorem.word }
    website {'www.foobar.com'}
  end
end