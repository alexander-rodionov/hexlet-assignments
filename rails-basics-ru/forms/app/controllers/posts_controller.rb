# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @data = Post.all
  end

  def new
    @data = Post.new
  end

  def create
    permitted = params.require(:post).permit(:title, :body, :summary, :published )
    @data = Post.create(permitted)
    redirect_to post_path(@data)
  end

  def show
    @data = Post.find(params[:id])
  end

  def edit
    @data = Post.find(params[:id])
  end

  def update
    permitted = params.require(:post).permit(:id, :title, :body, :summary, :published )
    Post.find(params[:id]).update(permitted)
    @data = Post.find(params[:id])
    redirect_to post_path(@data)
    # @data = Post.find(params[:id])
    # render 'show'
  end

  def destroy
    p 'DESTROY'
    p params
    Post.find(params[:id]).destroy
    redirect_to posts_url
  end
end
