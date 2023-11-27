# frozen_string_literal: true

class Debit < ApplicationRecord # rubocop:todo Style/Documentation
  belongs_to :wallet, polymorphic: true, optional: true

  validates_presence_of :amount
end
