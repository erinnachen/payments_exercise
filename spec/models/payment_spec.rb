require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should belong_to :loan }

  it "calculates the total amount for a group of payments" do
    loan = Loan.create(funded_amount: 100.00)
    3.times do |n|
      Payment.create(amount: n+1.00, loan: loan)
    end
    expect(Payment.total_amount).to eq 6.00
  end

  it "should not be valid when amount is greater than outstanding loan amount" do
    loan = Loan.create!(funded_amount: 100.00)
    payment = Payment.new(amount: 150.00, loan: loan)
    expect(payment.valid?).to be false
  end

end
