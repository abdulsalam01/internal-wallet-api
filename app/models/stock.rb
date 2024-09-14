class Stock < ApplicationRecord
  has_one :wallet, as: :entity
  after_create :create_wallet

  private

  def create_wallet
    Wallet.new(balance: 0, entity: self)
  end
end
