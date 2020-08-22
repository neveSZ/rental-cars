require 'rails_helper'

feature 'User sign out' do
  scenario 'successfully' do
    user_login

    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso'
    expect(page).not_to have_link 'Sair'
    expect(page).not_to have_link 'João'
  end
end
