class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def create
    render json: Loan.find(params[:loan_id]).payments.create(payment_params)
  end

  private

    def payment_params
      params.require(:payment).permit(:amount)
    end
end
