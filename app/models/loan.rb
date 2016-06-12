class Loan < ActiveRecord::Base
  has_many :payments

  def as_json(options = {})
    super(options).merge({outstanding_balance: outstanding_balance})
  end

  def outstanding_balance
    funded_amount - payments.total_amount
  end
end
