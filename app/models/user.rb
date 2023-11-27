# frozen_string_literal: true

class User < ApplicationRecord
    has_secure_password

    has_one :wallet, as: :entity

    has_many :credits, as: :source_wallet
    has_many :debits, as: :target_wallet
    has_many :sessions
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
