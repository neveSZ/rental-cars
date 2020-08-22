require 'cpf_cnpj'

class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    errors.add(:cnpj, 'não é válido') unless CNPJ.valid?(cnpj, strict: true)
  end
end
