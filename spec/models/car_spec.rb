require 'rails_helper'

RSpec.describe Car, type: :model do
  describe '.description' do
    it 'should return car model name, color and license plate' do
      car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
      car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0,
                                   car_category: car_category, fuel_type: 'Flex')
      subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')
      car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model, mileage: 0, subsidiary: subsidiary)

      result = car.description
      expect(result).to eq 'Celta - Prata - ABC123'
    end
  end
end
