FactoryBot.define do
  factory :user do
    name {'Joao Teste'}
    sequence(:email) { |i| "joao.teste#{i}@email.com" }
    password {'123456'}
  end
end
