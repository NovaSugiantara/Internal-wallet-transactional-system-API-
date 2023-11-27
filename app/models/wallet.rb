# app/models/wallet.rb
class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :source_wallet, polymorphic: true, optional: true
  belongs_to :target_wallet, polymorphic: true, optional: true
  has_many :debits
  has_many :credits

  attribute :wallet_type, :string
  attribute :balance, :decimal, default: 0.0 # Initialize balance with a default value

  validates_presence_of :entity_type
  validate :validate_transaction, on: :update

  def update_balance_after_credit(amount)
    new_balance = balance.to_f + amount
    update_column(:balance, new_balance)
  end

  def update_balance_after_debit(amount)
    new_balance = [balance.to_f - amount, 0].max
    update_column(:balance, new_balance)
  end

  private

  def validate_transaction
    return unless persisted?
    return if source_wallet.present? || target_wallet.present?

    errors.add(:base, 'Either source_wallet or target_wallet must be present')
  end
end
