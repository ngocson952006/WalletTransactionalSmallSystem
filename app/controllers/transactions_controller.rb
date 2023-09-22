# frozen_string_literal: true

class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
    render json: @transactions, each_serializer: TransactionSerializer
  end

  def show
    @transaction = Transaction.find(params[:id])
    render json: @transaction, serialize: TransactionSerializer
  end

  # Delegate service to handle via messages for notification.
  # For this demo, I just use simple lib https://github.com/krisleech/wisper for demonstration.
  # For production, we may use another reliable framework like RabbitMQ or Kafka
  def create
    TransactionCreator.new(transaction_params).perform

    render json: { message: 'The transaction is being processed' }
  end

  private

  def transaction_params
    params.require(:transaction).permit(:source_wallet_id,
                                        :target_wallet_id,
                                        :amount,
                                        :description,
                                        :transaction_type)
  end
end
