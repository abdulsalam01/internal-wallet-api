class CreateTransferTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transfer_transactions do |t|
      t.string :parent
      t.string :Transaction

      t.timestamps
    end
  end
end
