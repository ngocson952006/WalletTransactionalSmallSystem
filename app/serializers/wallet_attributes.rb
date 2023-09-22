# frozen_string_literal: true

module WalletAttributes
  def wallet
    @wallet ||= WalletSerializer.new(object.wallet)
  end
end
