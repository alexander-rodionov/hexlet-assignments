# frozen_string_literal: true

class BulletinsController < ApplicationController
  # BEGIN
  def index
    @data = Bulletin.where(published: true)
  end

  def show
    @data = Bulletin.find_by(id: params[:id])
  end
  # END
end
