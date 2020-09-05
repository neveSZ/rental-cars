require 'rails_helper'

feature 'Admin searches rental' do
  scenario 'and find exact match' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: rental.token
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).not_to have_content(another_rental.token)
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.client.cpf)
    expect(page).to have_content(rental.car_category.name)
  end

  xscenario 'and finds nothing' do
  end

  xscenario 'finds by partial token' do
  end
end
