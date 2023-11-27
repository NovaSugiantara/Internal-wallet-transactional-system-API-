# frozen_string_literal: true

class CreateSessions < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    create_table :sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
