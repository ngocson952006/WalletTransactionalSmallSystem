# frozen_string_literal: true

class WalletSerializer < ActiveModel::Serializer
  attributes :id, :status, :balance, :transactions

  private

  def transactions
    object.transactions
  end
end
