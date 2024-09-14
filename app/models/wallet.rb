class Wallet < ApplicationRecord
  has_many :debit_transactions, class_name: "Transaction", foreign_key: :source_wallet_id
  has_many :credit_transactions, class_name: "Transaction", foreign_key: :source_wallet_id
  has_many :transfer_transactions, class_name: "Transaction", foreign_key: :target_wallet_id

  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # Ensure wallet balance is never negative.
  def can_withdraw?(amount)
    balance >= amount
  end
end
