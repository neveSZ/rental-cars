require 'cpf_cnpj'

class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :cnpj, uniqueness: { case_sensitive: false }
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    unless CNPJ.valid?(cnpj, strict: true)
      errors.add(:cnpj, 'não é válido')
      print
    end
  end
end
