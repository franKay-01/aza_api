require "utilities"

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]
  before_action :authorize_request
  @@util = Utilities::Util.new

  # GET /transactions
  def index
    @transactions = Transaction.where(customer_id: @current_user.uuid).order('created_at desc')
    
    if @transactions
      render json: { resp_code: SUCCESS, payload: @transactions }, status: :ok
    else
      render json: @@util.send_failed_response('No record found')
    end
  end

  # GET /transactions/1
  def show
    @transaction = Transaction.where(id: params[:id])
    
    if @transaction
      render json: @@util.send_success_response(@transaction)
    else
      render json: @@util.send_failed_response('No record found')
    end

    
  end

  def get_transaction
    render json: Transaction.where(uuid: params[:uuid])
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.uuid = @@util.gen_assigned_code('transaction_seq')
    @transaction.output_amount = @@util.calculate_amount(transaction_params[:amount])
    @transaction.customer_id = @current_user.uuid
    @transaction.output_currency = transaction_params[:amount_currency]

    if @transaction.save
      render json: @@util.send_success_response(@transaction.as_json(only: [:uuid, :amount, :output_amount, :amount_currency, :output_currency]))
    else
      render json: @@util.send_failed_response(@transaction.errors)
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:id, :uuid, :customer_id, :amount, :output_amount, :amount_currency, :output_currency, :created_at, :updated_at)
    end
end
