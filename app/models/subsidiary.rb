require 'cpf_cnpj'

class Subsidiary < ApplicationRecord
  validates :cnpj, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_must_be_valid

  private def cnpj_must_be_valid
    errors.add(:cnpj, 'não é válido') unless CNPJ.valid?(cnpj, strict: true)
  end
end
