class AddWalletTypeToDebit < ActiveRecord::Migration[7.1]
  def change
    add_column :debits, :wallet_type, :string
  end
end
