# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :address, :full_name
  has_many :posts, serializer: PostSerializer
end
