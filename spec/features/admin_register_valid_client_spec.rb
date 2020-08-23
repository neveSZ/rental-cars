require 'rails_helper'

feature 'Admin register valid client' do
  scenario 'and alls fiedls must be filled' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and cpf must be unique' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Maria'
    fill_in 'CPF', with: '359.787.110-03'
    fill_in 'Email', with: 'maria@mail.com'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and cpf must be valid' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Maria'
    fill_in 'CPF', with: '359.787.110-04'
    fill_in 'Email', with: 'maria@mail.com'
    click_on 'Enviar'

    expect(page).to have_content('não é válido')
  end
end
