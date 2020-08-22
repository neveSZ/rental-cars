require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@mail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    expect(page).to have_content 'João'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end
end
