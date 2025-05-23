# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  # BEGIN
  def show
    respond_with(User.find_by(params[:id]))
  end

  def index
    respond_with(User.all)
  end
  # END
end
