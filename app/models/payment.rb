class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :loan, presence: true

  def self.total_amount
    sum(:amount)
  end
end
