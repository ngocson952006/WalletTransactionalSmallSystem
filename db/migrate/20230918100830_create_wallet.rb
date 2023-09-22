class CreateWallet < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.decimal :balance
      t.integer :status, default: 0
      t.references :ownerable, polymorphic: :true
      t.timestamps
    end
  end
end
