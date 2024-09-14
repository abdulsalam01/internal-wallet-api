# app/models/transaction.rb
class Transaction < ApplicationRecord
  # Relationships
  belongs_to :source_wallet, class_name: "Wallet", foreign_key: :source_wallet_id
  belongs_to :target_wallet, class_name: "Wallet", foreign_key: :target_wallet_id, optional: true

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :valid_wallets

  # Shared behavior for credit and debit type.
  def process_transaction
    Rails.logger.debug "Processing transaction: #{self.inspect}"
  end

  private

  def valid_wallets
    errors.add(:source_wallet, "cannot be the same as target wallet") if source_wallet_id == target_wallet_id
  end
end
