class TransactionsController < ApplicationController
  before_action :authenticate_request

  def index
    # Fetch transactions associated with the source wallet, with pagination.
    @transactions = Transaction
      .where(source_wallet_id: @wallet.id)
      .page(params[:page] || 1)
      .per(params[:per_page] || 10)

    render json: {
      wallet: @wallet,
      transactions: @transactions.as_json(include: [ :source_wallet, :target_wallet ])
    }
  end

  def create
    transaction = build_transaction(transaction_params)

    if transaction.save
      render json: { data: transaction.as_json.merge(latest_balance: @wallet.balance) }, status: :created
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def build_transaction(params)
    params[:source_wallet_id] = @wallet.id

    case params[:transaction_type]
    when TransactionTypeConstant::CREDIT_TYPE
      CreditTransaction.new(params)
    when TransactionTypeConstant::DEBIT_TYPE
      DebitTransaction.new(params)
    when TransactionTypeConstant::TRANSFER_TYPE
      TransferTransaction.new(params)
    else
      raise ArgumentError, "Invalid transaction type"
    end
  end

  def transaction_params
    params.require(:transaction).permit(
      :target_wallet_id,
      :amount,
      :description,
      :transaction_type
    ).tap do |permitted|
      # Remove `target_wallet_id` if the transaction type is not a transfer.
      permitted.delete(:target_wallet_id) unless transaction_type_transfer?
    end
  end

  def transaction_type_transfer?
    params.dig(:transaction, :transaction_type) == TransactionTypeConstant::TRANSFER_TYPE
  end
end
