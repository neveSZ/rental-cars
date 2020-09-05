require 'rails_helper'

RSpec.describe Rental, type: :model do
  context 'token' do
    it 'generate on create' do
      client = Client.create!(name: 'Joao', email: 'joao@mail.com', cpf: '101.662.897-87')
      car_category = CarCategory.create!(name: 'Top', daily_rate: 10, car_insurance: 10, third_party_insurance: 10)
      user = User.create!(email: 'maria@mail.com', name: 'Maria', password: '12345678')
      rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now, client: client, user: user, car_category: car_category)

      rental.save!
      rental.reload

      expect(rental.token).to be_present
      expect(rental.token.size).to eq(6)
      expect(rental.token).to match(/^[A-Z0-9]+$/)
    end
  end
end
