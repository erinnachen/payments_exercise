class PaymentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.find(params[:loan_id]).payments
  end

  def show
    render json: Loan.find(params[:loan_id]).payments.find(params[:id])
  end

  def create
    @payment = Loan.find(params[:loan_id]).payments.new(payment_params)
    if @payment.save
      render json: @payment
    else
      render json: { errors: @payment.errors.full_messages }, status: 422
    end
  end

  private

    def payment_params
      params.require(:payment).permit(:amount)
    end
end
