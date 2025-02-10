# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, inclusion: { in: [true, false] }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= 'new'
  end
end
