class AddWalletTypeToWallets < ActiveRecord::Migration[7.1]
  def change
    add_column :wallets, :wallet_type, :string
  end
end
