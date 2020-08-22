require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cant be blank' do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
    end

    it 'cnpj must be valid' do
      subsidiary = Subsidiary.new(cnpj: '123')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end

    it 'name must be uniq' do
      Subsidiary.create!(name: 'LojaA', cnpj: '99.510.842/0001-50', address: 'rua A')
      subsidiary = Subsidiary.new(cnpj: '99.510.842/0001-50')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end
  end
end
