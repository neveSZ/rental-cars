require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      subsidiary = Subsidiary.create!(name: 'A', cnpj: '10.990.573/0001-63', address: 'Rua A')
      car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
      car_model = CarModel.create!(name: 'Celta', year: 2008, manufacturer: 'Ford', fuel_type: 'Flex', motorization: 1.0,
                                   car_category: car_category)
      Car.create!(license_plate: 'ABC123', mileage: 10, color: 'Preto', car_model: car_model, subsidiary: subsidiary, status: :available)
      Car.create!(license_plate: 'CDE456', mileage: 10, color: 'Prata', car_model: car_model, subsidiary: subsidiary, status: :rented)
      Car.create!(license_plate: 'EFG789', mileage: 10, color: 'Vermelho', car_model: car_model, subsidiary: subsidiary, status: :available)

      get api_v1_cars_path

      expect(response).to have_http_status(200)
      expect(response.body).to include('ABC123')
      expect(response.body).to include('EFG789')
      expect(response.body).to_not include('CDE456')
    end
  end
end
