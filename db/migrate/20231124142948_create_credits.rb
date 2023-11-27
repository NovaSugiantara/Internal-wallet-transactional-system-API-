# frozen_string_literal: true

class CreateCredits < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    create_table :credits do |t|
      t.decimal :amount
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
