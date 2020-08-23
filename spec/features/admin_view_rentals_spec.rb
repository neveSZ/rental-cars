require 'rails_helper'

feature 'Admin view rentals scheduled' do
  scenario 'and view list' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Top', daily_rate: 100, car_insurance: 50, third_party_insurance: 10)
    client = Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')
    Rental.create!(start_date: '23/08/2050', end_date: '25/08/2050', car_category: car_category, client: client, user: user)

    visit root_path
    click_on 'Locações'

    expect(page).to have_link('23/08/2050 - 25/08/2050')
  end

  scenario 'and view details' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    car_category = CarCategory.create!(name: 'Top', daily_rate: 100, car_insurance: 50, third_party_insurance: 10)
    client = Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')
    Rental.create!(start_date: '23/08/2050', end_date: '25/08/2050', car_category: car_category, client: client, user: user)

    visit root_path
    click_on 'Locações'
    click_on '23/08/2050 - 25/08/2050'

    expect(page).to have_content('23/08/2050')
    expect(page).to have_content('25/08/2050')
    expect(page).to have_content('R$ 320,00')
    expect(page).to have_content(car_category.name)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content(client.email)
  end

  scenario 'and nothing registered' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Nenhuma locação agendada')
  end

  scenario 'must be signed in' do
    visit root_path

    expect(page).to_not have_content('Locações')
  end

  scenario 'must be logged in to view rentals list' do
    visit rentals_path

    expect(current_path).to eq new_user_session_path
  end
end
