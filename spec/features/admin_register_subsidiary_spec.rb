require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_link('Registrar uma nova filial',
                              href: new_subsidiary_path)
  end

  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'

    fill_in 'Nome', with: 'Loja A'
    fill_in 'CNPJ', with: '62.153.546/0001-30'
    fill_in 'Endereço', with: 'Rua 10'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Loja A')
    expect(page).to have_content('62.153.546/0001-30')
    expect(page).to have_content('Rua 10')
    expect(page).to have_link('Voltar')
  end
end
