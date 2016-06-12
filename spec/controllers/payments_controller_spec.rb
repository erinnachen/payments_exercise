require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 201' do
      post :create, loan_id: loan.id, payment: { amount: 30.00 }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["amount"]).to eq "30.0"
    end
  end
end
