require 'rails_helper'

feature 'Admin view car model' do
  scenario 'and view list' do
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'KA', year: 2008, manufacturer: 'Ford', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Celta')
    expect(page).to have_content('2006')
    expect(page).to have_content('Ford')
    expect(page).to have_content('KA')
    expect(page).to have_content('2008')
    expect(page).to have_content('Basic', count: 2)
  end

  scenario 'and view details' do
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'KA', year: 2008, manufacturer: 'Ford', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Celta'

    expect(page).to have_content('Celta')
    expect(page).to have_content('2006')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Flex')
    expect(page).to have_content('Basic')
    expect(page).to have_content('R$ 200,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 20,00')
    expect(page).not_to have_content('KA')
  end

  scenario 'and nothing is registered' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'and return to home page' do
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to car models page' do
    car_category = CarCategory.create!(name: 'Basic', daily_rate: 200, car_insurance: 50, third_party_insurance: 20)
    CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Celta'
    click_on 'Voltar'

    expect(current_path).to eq car_models_path
  end
end
