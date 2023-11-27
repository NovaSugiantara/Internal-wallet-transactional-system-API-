# frozen_string_literal: true

class Session < ApplicationRecord # rubocop:todo Style/Documentation
  belongs_to :user

  validates :token, presence: true, uniqueness: true
end
