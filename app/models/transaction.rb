# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum status: [:inprogress, :successful, :failed]

  # For this demo, I just make it simple with 2 type of transactions: withdraw and transfer to another wallets
  enum transaction_type: [:withdraw, :transfer]

  has_one :source_wallet, class_name: 'Wallet', foreign_key: :id, primary_key: :source_wallet_id
  has_one :target_wallet, class_name: 'Wallet', foreign_key: :id, primary_key: :target_wallet_id

  scope :success, -> { where(status: :successful) }

  validate :validate_source_target_wallet

  private

  def validate_source_target_wallet
    if self.withdraw? && source_wallet_id.blank?
      errors.add(:source_wallet_id,
                 "Source wallet must not be blank for Withdraw transaction type")
    end

    if self.transfer? && (source_wallet_id.blank? || target_wallet_id.blank?)
      if source_wallet_id.blank?
        errors.add(:source_wallet_id,
                   "Source wallet must not be blank for Transfer transaction type")
      end

      if target_wallet_id.blank?
        errors.add(:target_wallet_id,
                   "Target wallet must not be blank for Transfer transaction type")
      end
    end
  end
end
