# frozen_string_literal: true

class TransactionCreator
  attr_reader :transaction_params

  def initialize(transaction_params)
    @transaction_params = transaction_params
  end

  def perform
    transaction_create_publisher = TransactionCreatePublisher.new(transaction_params)
    transaction_create_publisher.subscribe(TransactionCreateSubscriber.new, async: true)
    transaction_create_publisher.perform
  end
end
