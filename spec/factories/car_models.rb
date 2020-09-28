FactoryBot.define do
  factory :car_model do
    sequence(:name) { |i| "Ka#{i}" }
    year { 2019 }
    manufacturer { 'Ford' }
    motorization { '1.0' }
    fuel_type { 'Flex' }
    car_category
  end
end
