require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { should belong_to :loan }
  it { should validate_presence_of :loan }

  it "calculates the total amount for a group of payments" do
    loan = Loan.create(funded_amount: 100.00)
    3.times do |n|
      Payment.create(amount: n+1.00, loan: loan)
    end
    expect(Payment.total_amount).to eq 6.00
  end
end
