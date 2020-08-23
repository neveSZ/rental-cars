require 'rails_helper'

feature 'Admin schedule rentail' do
  scenario 'successfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 100, car_insurance: 50, third_party_insurance: 10)
    Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')

    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    fill_in 'Data de início', with: '22/08/2050'
    fill_in 'Data de término', with: '23/08/2050'
    select 'Fulano Sicrano - 359.787.110-03', from: 'Cliente'
    select 'Top', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('22/08/2050')
    expect(page).to have_content('23/08/2050')
    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('359.787.110-03')
    expect(page).to have_content('fulano@mail.com')
    expect(page).to have_content('Top')
    expect(page).to have_content('R$ 160,00')
    expect(page).to have_content('Agendamento realizado com sucesso')
  end
end
