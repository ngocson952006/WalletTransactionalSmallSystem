class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :source_wallet, foreign_key: { to_table: 'wallets' }
      t.references :target_wallet, foreign_key: { to_table: 'wallets' }
      t.decimal :amount
      t.string :description
      t.integer :transaction_type, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
