# frozen_string_literal: true

# Create a transaction
class TransactionCreatePublisher
  include Wisper::Publisher

  attr_reader :transaction_params

  def initialize(transaction_params)
    @transaction_params = transaction_params
  end

  def perform
    transaction = Transaction.new(transaction_params)
    return broadcast(:process_transaction, transaction.id) if transaction.save

    broadcast(:notify_invalid_transaction, transaction.errors.full_messages.join(', '))
  end
end
