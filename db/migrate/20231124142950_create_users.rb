# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1] # rubocop:todo Style/Documentation
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end