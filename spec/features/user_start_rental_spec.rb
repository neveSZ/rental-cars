require 'rails_helper'

include ActiveSupport::Testing::TimeHelpers

feature 'User start rental' do
  scenario 'view only category cars' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
    car_category_top = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    car_category_special = CarCategory.create!(name: 'Special', daily_rate: 10, car_insurance: 10,
                                               third_party_insurance: 10)
    car_model_celta = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0,
                                       car_category: car_category_top, fuel_type: 'Flex')
    car_model_ka = CarModel.create!(name: 'Ka', year: 2006, manufacturer: 'Ford', motorization: 1.0,
                                    car_category: car_category_special, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')
    car_celta = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model_celta, mileage: 0,
                            subsidiary: subsidiary)
    car_ka = Car.create!(license_plate: 'CDE345', color: 'Preto', car_model: car_model_ka, mileage: 0,
                         subsidiary: subsidiary)
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user,
                            car_category: car_category_top)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'

    expect(page).to have_content(car_celta.car_model.name)
    expect(page).to have_content(car_celta.color)
    expect(page).to have_content(car_celta.license_plate)
    expect(page).to_not have_content(car_ka.car_model.name)
    expect(page).to_not have_content(car_ka.color)
    expect(page).to_not have_content(car_ka.license_plate)
  end

  scenario 'successfully' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    car_model = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0,
                                 car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')
    schedule_user = User.create!(email: 'user@mail.com', name: 'User', password: '12345678')
    user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: schedule_user,
                            car_category: car_category)
    car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model, mileage: 0, subsidiary: subsidiary,
                      status: :available)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}", from: 'Carros disponíveis'
    fill_in 'CNH do condutor', with: 'SP123456'
    travel_to Time.zone.local(2020, 10, 0o1, 12, 30, 45) do
      click_on 'Iniciar'
    end

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(user.email)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('SP123456')
    expect(page).to_not have_link('Iniciar locação')
    expect(page).to have_content('01 de outubro de 2020, 12:30:45')
    expect(car.reload).to be_rented
    expect(page).to have_content('Em andamento')
  end

  scenario 'view only available cars' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    car_model_celta = CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0,
                                       car_category: car_category, fuel_type: 'Flex')
    car_model_ka = CarModel.create!(name: 'Ka', year: 2006, manufacturer: 'Ford', motorization: 1.0,
                                    car_category: car_category, fuel_type: 'Flex')
    subsidiary = Subsidiary.create!(name: 'LojaB', cnpj: '52.942.727/0001-91', address: 'rua B')
    car = Car.create!(license_plate: 'ABC123', color: 'Prata', car_model: car_model_celta, mileage: 0,
                      subsidiary: subsidiary, status: :available)
    car_other = Car.create!(license_plate: 'XYZ123', color: 'Azul', car_model: car_model_celta, mileage: 0,
                            subsidiary: subsidiary, status: :rented)
    car_ka = Car.create!(license_plate: 'CDE345', color: 'Preto', car_model: car_model_ka, mileage: 0,
                         subsidiary: subsidiary, status: :rented)

    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user,
                            car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'
    click_on 'Ver detalhes'
    click_on 'Iniciar locação'

    expect(page).to have_content(car.license_plate)
    expect(page).to_not have_content(car_other.license_plate)
    expect(page).to_not have_content(car_ka.license_plate)
  end
end
