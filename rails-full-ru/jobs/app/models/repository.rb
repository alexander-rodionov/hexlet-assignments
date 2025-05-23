# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM
  validates :link, presence: true, uniqueness: true

  aasm do
    state :created, initial: true
    state :fetching
    state :fetched
    state :failed

    event :fetch do
      transitions from: :created, to: :fetching
    end

    event :success do
      transitions from: :fetching, to: :fetched
      transitions from: :fetched, to: :fetched
    end

    event :fail do
      transitions from: :fetching, to: :failed
    end
  end
end
