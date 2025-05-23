# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :link, presence: true
  def repo_created_at
    created_at
  end

  def repo_updated_at
    created_at
  end
end
