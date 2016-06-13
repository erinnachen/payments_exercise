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

    context 'payment amount greater than outstanding_balance' do
      it 'responds with a 422' do
        post :create, loan_id: loan.id, payment: { amount: 159.00 }
        json = JSON.parse(response.body)

        expect(response).to have_http_status(422)
      end
    end
  end

  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    it 'responds with a 200' do
      get :index, loan_id: loan.id
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { Payment.create!(amount: 50.0, loan: loan) }

    it 'responds with a 200' do
      get :show, loan_id: loan.id, id: payment.id
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["amount"]).to eq "50.0"
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, loan_id: loan.id, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
