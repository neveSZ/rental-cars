require 'rails_helper'

feature ' Admin register car model' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5, third_party_insurance: 10.5)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    fill_in 'Nome', with: 'Celta'
    fill_in 'Ano', with: '2006'
    fill_in 'Fabricante', with: 'Chevrolet'
    fill_in 'Motorização', with: '1.0'
    select 'Top', from: 'Categoria de carro'
    fill_in 'Tipo do combustível', with: 'Flex'
    click_on 'Enviar'

    expect(page).to have_content('Celta')
    expect(page).to have_content('2006')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  scenario 'must fill in all fields' do
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 5)
    expect(page).to have_content('é obrigatório(a)')
  end
end
