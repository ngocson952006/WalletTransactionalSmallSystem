# frozen_string_literal: true

class TeamSerializer < ActiveModel::Serializer
  include WalletAttributes

  attributes :id, :name, :wallet, :users
end
