# frozen_string_literal: true

json.array! @users do |user|
  json.id user.id
  json.email user.email
  json.address user.address
  json.full_name user.full_name
  json.posts user.posts, partial: 'post', as: :post
end
