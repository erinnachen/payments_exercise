require 'spec_helper'

RSpec.describe Loan, type: :model do
  it {should have_many :payments}

  it "has an outstanding balance" do
    loan = Loan.create!(funded_amount: 100.0)
    payment = Payment.create!(amount: 23.35, loan: loan)

    expect(loan.outstanding_balance).to eq 76.65.to_d
  end
end
