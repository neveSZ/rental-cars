require 'rails_helper'

feature 'Admin edit subsidiary' do
  scenario 'successfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    Subsidiary.create!(name: 'Loja A', cnpj: '65.118.391/0001-99', address: 'Rua A')

    visit root_path
    click_on 'Filiais'
    click_on 'Loja A'
    click_on 'Editar'
    fill_in 'Nome', with: 'Loja B'
    fill_in 'CNPJ', with: '64.090.070/0001-60'
    fill_in 'Endereço', with: 'Rua B'
    click_on 'Enviar'

    expect(page).to have_content('Loja B')
    expect(page).not_to have_content('Loja A')
    expect(page).to have_content('64.090.070/0001-60')
    expect(page).not_to have_content('65.118.391/0001-99')
    expect(page).to have_content('Rua B')
    expect(page).not_to have_content('Rua A')
  end

  scenario 'attributes cant be blank' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    Subsidiary.create!(name: 'Loja A', cnpj: '65.118.391/0001-99', address: 'Rua A')

    visit root_path
    click_on 'Filiais'
    click_on 'Loja A'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'cnpj must be unique' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    Subsidiary.create!(name: 'Loja A', cnpj: '65.118.391/0001-99', address: 'Rua A')
    Subsidiary.create!(name: 'Loja B', cnpj: '64.090.070/0001-60', address: 'Rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'Loja A'
    click_on 'Editar'
    fill_in 'CNPJ', with: '64.090.070/0001-60'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
end
