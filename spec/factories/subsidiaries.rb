FactoryBot.define do
  factory :subsidiary do
    name {'Loja A'}
    cnpj { CNPJ.generate(true) }
    address {'Rua A'}
  end
end
