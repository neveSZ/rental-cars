FactoryBot.define do
  factory :car_category do
    sequence(:name) { |i| "Top#{i}" }
    daily_rate { 10 }
    car_insurance { 10 }
    third_party_insurance { 10 }
  end
end
