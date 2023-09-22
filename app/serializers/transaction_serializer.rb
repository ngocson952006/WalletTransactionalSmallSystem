# frozen_string_literal: true

class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
             :source_wallet_id,
             :target_wallet_id,
             :amount,
             :transaction_type,
             :status,
             :created_at,
             :updated_at
end
