require 'rails_helper'

feature 'Admin view car models from a car category' do
  scenario 'successfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    top = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5, third_party_insurance: 10.5)
    CarModel.create!(name: 'Celta', year: 2006, manufacturer: 'Chevrolet', motorization: 1.0, car_category: top, fuel_type: 'Flex')
    CarModel.create!(name: 'KA', year: 2008, manufacturer: 'Ford', motorization: 1.0, car_category: top, fuel_type: 'Flex')

    visit root_path
    click_on 'Categorias'
    click_on 'Top'

    expect(page).to have_content('Top')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_link('Celta')
    expect(page).to have_content('2006')
    expect(page).to have_content('Ford')
    expect(page).to have_link('KA')
    expect(page).to have_content('2008')
  end
end
