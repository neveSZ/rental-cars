require 'rails_helper'

feature 'Admin deletes car category' do
  scenario 'successfully' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and keep anothers' do
    user = User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')
    login_as(user, scope: :user)
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    CarCategory.create!(name: 'Flex', daily_rate: 80, car_insurance: 8.5,
                        third_party_insurance: 8.5)

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Apagar'

    expect(current_path).to eq car_categories_path
    expect(page).not_to have_content('Top')
    expect(page).to have_content('Flex')
  end
end
