class TransferTransaction < Transaction
    # Set the type as 'debit'
    before_validation :set_transaction_type
    before_save :process_transaction

    def process_transaction
      if source_wallet.balance >= amount
        source_wallet.update!(balance: source_wallet.balance - amount)
        target_wallet.update!(balance: target_wallet.balance + amount)
      else
        errors.add(:base, "Insufficient funds in source wallet")
        throw(:abort)
      end
    end

    private

    def set_transaction_type
      self[:transaction_type] = TransactionTypeConstant::TRANSFER_TYPE
    end
end
