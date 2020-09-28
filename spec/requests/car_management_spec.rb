require 'rails_helper'

describe 'Car management' do
  context 'index' do
    it 'renders available cars' do
      car_model = create(:car_model)
      subsidiary = create(:subsidiary)
      create(:car, license_plate: 'ABC123', color: 'Preto', status: :available, subsidiary: subsidiary,
                   car_model: car_model)
      create(:car, license_plate: 'CDE456', color: 'Prata', status: :rented, subsidiary: subsidiary,
                   car_model: car_model)
      create(:car, license_plate: 'EFG789', color: 'Vermelho', status: :available, subsidiary: subsidiary,
                   car_model: car_model)

      get api_v1_cars_path

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[0][:license_plate]).to eq('ABC123')
      expect(body[0][:color]).to eq('Preto')
      expect(body[1][:license_plate]).to eq('EFG789')
      expect(body[1][:car_model_id]).to eq(car_model.id)
      expect(response.body).to_not include('CDE456')
    end

    it 'renders empty json' do
      get api_v1_cars_path

      response_json = JSON.parse(response.body)
      expect(response).to be_ok
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_empty
    end
  end

  context 'show' do
    context 'record exists' do
      let(:car) do
        create(:car)
      end

      it 'return 200 status' do
        get api_v1_cars_path(car)
        expect(response).to be_ok
      end

      it 'return cars' do
        get api_v1_cars_path(car)

        response_json = JSON.parse(response.body, symbolize_names: true)[0]
        expect(response_json[:license_plate]).to eq(car.license_plate)
        expect(response_json[:color]).to eq(car.color)
        expect(response_json[:car_model_id]).to eq(car.car_model.id)
        expect(response_json[:license_plate]).to eq(car.license_plate)
      end
    end

    context 'record not exist' do
      it 'returns code 404' do
        get '/api/v1/cars/000'

        expect(response).to be_not_found
      end

      it 'return not found message' do
        get '/api/v1/cars/000'

        expect(response.body).to include('Carro não encontrado')
      end
    end
  end

  context 'create' do
    context 'with valid parameters' do
      let(:car_model) {create(:car_model)}
      let(:subsidiary) {create(:subsidiary)}
      let(:attributes) { attributes_for(:car, car_model_id: car_model.id, subsidiary_id: subsidiary.id)}

      it 'return 201 status code' do
        post api_v1_cars_path, params: { car: attributes }

        expect(response).to be_created
      end

      it 'creates a car' do
        post api_v1_cars_path, params: { car: attributes }

        car = JSON.parse(response.body, symbolize_names: true)
        expect(car[:id]).to be_present
        expect(car[:license_plate]).to eq(attributes[:license_plate])
        expect(car[:color]).to eq(attributes[:color])
        expect(car[:car_model_id]).to eq(attributes[:car_model_id])
      end
    end

    context 'with invalid parameters' do
      it 'without requested params' do
        post api_v1_cars_path, params: { car: { foo: 'asd' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Placa não pode ficar em branco')
        expect(response.body).to include('Cor não pode ficar em branco')
        expect(response.body).to include('Quilometragem não pode ficar em branco')
        expect(response.body).to include('Modelo de carro é obrigatório(a)')
        expect(response.body).to include('Filial é obrigatório(a)')
      end

      it 'without car key' do
        post api_v1_cars_path

        expect(response).to have_http_status(:precondition_failed)
        expect(response.body).to include('Paramêtros inválidos')
      end
    end
  end
end
