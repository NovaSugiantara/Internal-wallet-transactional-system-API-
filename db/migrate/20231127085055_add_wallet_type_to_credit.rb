class AddWalletTypeToCredit < ActiveRecord::Migration[7.1]
  def change
    add_column :credits, :wallet_type, :string
  end
end
