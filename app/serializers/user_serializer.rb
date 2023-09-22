class UserSerializer < ActiveModel::Serializer
  include WalletAttributes

  attributes :id, :username, :wallet
end
