# frozen_string_literal: true

class Vacancy < ApplicationRecord
  include AASM

  validates :title, presence: true
  validates :description, presence: true

  # BEGIN
  aasm do
    state :on_moderate
    state :published
    state :archived

    event :publish do
      transitions from: :on_moderate, to: :published
    end

    event :archive do
      transitions from: :published, to: :archived
      transitions from: :on_moderate, to: :archived
    end
  end
  # END
end
