# frozen_string_literal: true

class Wallet < ApplicationRecord
  enum status: [:active, :disabled]

  belongs_to :ownerable, polymorphic: true

  def transactions
    @transactions ||= Transaction.where("source_wallet_id = :id OR target_wallet_id = :id", id: self.id)
  end
end
