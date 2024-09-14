# app/models/credit_transaction.rb
class CreditTransaction < Transaction
  # Set the type as 'credit'
  before_validation :set_transaction_type
  before_save :process_transaction

  def process_transaction
    source_wallet.update!(balance: source_wallet.balance + amount)
  end

  private

  def set_transaction_type
    self[:transaction_type] = TransactionTypeConstant::CREDIT_TYPE
  end
end
