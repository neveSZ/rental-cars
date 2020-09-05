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

  scenario 'and finds nothing' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    user = User.create!(email: 'mari@mail.com', name: 'Maria', password: '12345678')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: 'AKOSDKAOD'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma locação encontrada')
  end

  scenario 'finds by partial token' do
    client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
    car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
    user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)
    rental.update(token: 'ABC123')
    another_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)
    another_rental.update(token: 'ABC456')
    rental_not_to_be_found = Rental.create!(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)
    rental_not_to_be_found.update(token: '789101')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Busca de locação', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).to have_content(another_rental.token)
    expect(page).not_to have_content(rental_not_to_be_found.token)
  end
end
