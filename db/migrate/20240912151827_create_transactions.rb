class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.string :transaction_type # Will store 'debit','credit' or 'transfer'
      t.references :source_wallet, null: false, foreign_key: { to_table: :wallets }
      t.references :target_wallet, null: true, foreign_key: { to_table: :wallets }
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :description

      t.timestamps
    end

    add_index :transactions, :transaction_type
  end
end
