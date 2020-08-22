def user_login
  User.create!(name: 'João', email: 'joao@mail.com', password: '12345678')

  visit root_path
  click_on 'Entrar'
  fill_in 'Email', with: 'joao@mail.com'
  fill_in 'Senha', with: '12345678'
  click_on 'Entrar'
end
