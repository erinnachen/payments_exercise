class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :loan, presence: true
  validate :amount_less_than_outstanding_balance

  def self.total_amount
    sum(:amount)
  end

  def amount_less_than_outstanding_balance
    if amount >= loan.outstanding_balance
      errors.add(:amount, "can't be greater than loan's outstanding balance")
    end
  end
end
