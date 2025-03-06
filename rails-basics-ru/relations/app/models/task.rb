# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :status
end
