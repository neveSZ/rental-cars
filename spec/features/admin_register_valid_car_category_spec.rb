require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and name must be unique' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'

    expect(CarCategory.count).to eq 0
    expect(page).to have_content('não pode ficar em branco', count: 4)
  end

  scenario 'and name is not case sensitive' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'all prices must be greather than 0' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'top'
    fill_in 'Diária', with: '0'
    fill_in 'Seguro do carro', with: '-1'
    fill_in 'Seguro para terceiros', with: '-1'
    click_on 'Enviar'

    expect(page).to have_content('deve ser maior que 0', count: 3)
  end
end
