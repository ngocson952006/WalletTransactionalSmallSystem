# frozen_string_literal: true

class Team < ApplicationRecord
  validates_presence_of :name
  belongs_to :login_user, class_name: 'User', foreign_key: 'login_user_id'

  has_many :users
  has_one :wallet, as: :ownerable
end
