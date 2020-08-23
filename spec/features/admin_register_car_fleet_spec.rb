require 'rails_helper'

feature 'Admin register a car in the fleet' do
  scenario 'succesfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaB'
    click_on 'Registrar um novo carro'
    fill_in 'Placa', with: 'ABC-2000'
    fill_in 'Cor', with: 'Preto'
    select 'Celta', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: '1000'
    select 'LojaB', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Carro cadastrado com sucesso')
    expect(page).to have_content('ABC-2000')
  end

  scenario 'must fill all fields' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaB'
    click_on 'Registrar um novo carro'
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'license plate must be uniq' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')
    Car.create!(license_plate: 'ABC-2000', color: 'Preto', car_model: car_model, mileage: 1000, subsidiary: subsidiary)

    visit root_path
    click_on 'Filiais'
    click_on 'LojaB'
    click_on 'Registrar um novo carro'
    fill_in 'Placa', with: 'ABC-2000'
    fill_in 'Cor', with: 'Preto'
    select 'Celta', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: '1000'
    select 'LojaB', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'mileage must be greater than 0' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaB'
    click_on 'Registrar um novo carro'
    fill_in 'Placa', with: 'ABC-2000'
    fill_in 'Cor', with: 'Preto'
    select 'Celta', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: '-1'
    select 'LojaB', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('deve ser maior ou igual a 0')
  end

  scenario 'mileage must be integer' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaB'
    click_on 'Registrar um novo carro'
    fill_in 'Placa', with: 'ABC-2000'
    fill_in 'Cor', with: 'Preto'
    select 'Celta', from: 'Modelo de carro'
    fill_in 'Quilometragem', with: '100.5'
    select 'LojaB', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('não é um número inteiro')
  end
end
