require 'rails_helper'

feature 'User sign out' do
  scenario 'successfully' do
    User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'joao@mail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_link 'João'
  end
end
