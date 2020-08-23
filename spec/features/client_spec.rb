require 'rails_helper'

describe Client, type: :model do
  context 'validation' do
    it 'fields cant be blank' do
      client = Client.new

      client.valid?

      expect(client.errors[:name]).to include('não pode ficar em branco')
      expect(client.errors[:cpf]).to include('não pode ficar em branco')
      expect(client.errors[:email]).to include('não pode ficar em branco')
    end

    it 'cpf must be longer than 11 characters' do
      client = Client.new(cpf: '123456')

      client.valid?

      expect(client.errors[:cpf]).to include('não é válido')
    end

    it 'cpf must be valid structure' do
      client = Client.new(cpf: '359.787.110-04')

      client.valid?

      expect(client.errors[:cpf]).to include('não é válido')
    end

    it 'cpf must be uniq' do
      Client.create!(name: 'Fulano Sicrano', cpf: '359.787.110-03', email: 'fulano@mail.com')
      client = Client.new(cpf: '359.787.110-03')

      client.valid?

      expect(client.errors[:cpf]).to include('já está em uso')
    end
  end
end
