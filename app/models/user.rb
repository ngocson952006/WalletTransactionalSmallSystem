# frozen_string_literal: true

class User < ApplicationRecord
  # For password, we may need to save via hash into database
  # But for this demo, i just keep it simple as string.
  validates_presence_of :username, :password
  validates :username, :email, uniqueness: true

  has_one :wallet, as: :ownerable


  # Check if the given value matches the one stored in DB
  def authenticate(password)
    self.password == password
  end

  def support_user?
    self.username == 'support_user'
  end
end
