# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  # BEGIN
  def index
    @users = User.includes(:posts).all
    render :index, formats: :json
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    render :show, formats: :json
  end
  # END
end
