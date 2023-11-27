# frozen_string_literal: true

class CreateWallets < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    create_table :wallets do |t|
      t.decimal :balance, default: 0.0
      t.references :source_wallet, polymorphic: true
      t.references :target_wallet, polymorphic: true

      t.timestamps
    end
  end
end
