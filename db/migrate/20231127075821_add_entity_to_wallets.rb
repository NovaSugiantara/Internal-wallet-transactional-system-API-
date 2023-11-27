class AddEntityToWallets < ActiveRecord::Migration[7.1]
  def change
    add_reference :wallets, :entity, polymorphic: true, null: false
  end
end
