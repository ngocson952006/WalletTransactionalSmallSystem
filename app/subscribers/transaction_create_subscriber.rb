# frozen_string_literal: true

class TransactionCreateSubscriber
  include Celluloid

  def process_transaction(transaction_id)
    handle_transaction(transaction_id)
  end

  def notify_invalid_transaction(error_messages)
    # May push notifications or emails for production
    puts "Invalid traction provided. Error: #{error_messages}"
  end

  private

  # Bases on information of the transactions, update balance of related wallets and update transaction status.
  # Rollback if any error raised.
  def handle_transaction(transaction_id)
    transaction = Transaction.find(transaction_id)

    ActiveRecord::Base.transaction do
      if transaction.source_wallet.balance < transaction.amount
        raise StandardError "Source wallet has invalid balance for this transaction"
      end
      transaction.update_attribute(:status, :successful)

      recalculate_wallet_balance(transaction.source_wallet)
      recalculate_wallet_balance(transaction.target_wallet)
    end
  rescue StandardError => e
    transaction.update(status: :failed, description: e.message)
  end

  def recalculate_wallet_balance(wallet)
    success_transactions = wallet.transactions.success.reload
    transactions_as_source_wallet_amount = success_transactions.where(source_wallet_id: wallet.id).sum(:amount)
    transactions_as_target_wallet_amount = success_transactions.where(target_wallet_id: wallet.id).sum(:amount)

    wallet.update_attribute(:balance, transactions_as_target_wallet_amount - transactions_as_source_wallet_amount)
  end
end
