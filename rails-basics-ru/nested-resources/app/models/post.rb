# frozen_string_literal: true

class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, length: { maximum: 500 }
  has_many :post_comments
end
