require 'rails_helper'

feature 'Admin register client' do
  scenario 'successfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar um novo cliente'
    fill_in 'Nome', with: 'Maria'
    fill_in 'CPF', with: '583.489.060-10'
    fill_in 'Email', with: 'maria@mail.com'
    click_on 'Enviar'

    expect(page).to have_content('Cliente registrado com sucesso')
  end
end
