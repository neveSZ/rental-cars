class Client < ApplicationRecord
  validates :name, :cpf, :email, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_must_be_valid

  def cpf_must_be_valid
    errors.add(:cpf, 'não é válido') unless CPF.valid?(cpf, strict: true)
  end

  def information
    "#{name} - #{cpf}"
  end
end
