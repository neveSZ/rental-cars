require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'LojaA', cnpj: '123', address: 'rua A')
    Subsidiary.create!(name: 'LojaB', cnpj: '456', address: 'rua B')

    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('LojaA')
    expect(page).to have_content('LojaB')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'LojaA', cnpj: '123', address: 'rua A')
    Subsidiary.create!(name: 'LojaB', cnpj: '456', address: 'rua B')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaA'

    expect(page).to have_content('LojaA')
    expect(page).to have_content('123')
    expect(page).to have_content('rua A')
    expect(page).not_to have_content('LojaB')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'LojaA', cnpj: '123', address: 'rua A')

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries list page' do
    Subsidiary.create!(name: 'LojaA', cnpj: '123', address: 'rua A')

    visit root_path
    click_on 'Filiais'
    click_on 'LojaA'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
end
