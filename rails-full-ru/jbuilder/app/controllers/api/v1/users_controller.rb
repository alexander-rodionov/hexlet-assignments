# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  # BEGIN
  def index
    @users = User.includes(:posts).all
    render :index, formats: :json
  end

  def show
    p params
    @user = User.includes(:posts).find(params[:id])
    p @user
    render :show, formats: :json
  end
  # END
end
