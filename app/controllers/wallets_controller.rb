# frozen_string_literal: true

class WalletsController < ApplicationController
  def index
    @wallets = Wallet.all
    render json: @wallets, each_serializer: WalletSerializer
  end

  def show
    @wallet = Wallet.find(params[:id])
    render json: @wallet, serialize: WalletSerializer
  end
end
