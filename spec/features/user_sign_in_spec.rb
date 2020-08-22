require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'successfully' do
    user_login

    expect(page).to have_content 'João'
    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end
end
