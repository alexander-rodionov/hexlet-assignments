# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(post_id)
  end

  def edit
    @post = Post.find(post_id)
    authorize(@post)
  end

  def update
    @post = Post.find(post_id)
    authorize(@post)
    Post.update!(post_params.to_hash)
    redirect_to post_path(@post)
  end

  def new
    @post = Post.new
    @post.author = current_user
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    @post.author = current_user
    @post.save!
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(post_id)
    authorize(@post)
    @post.destroy!
    redirect_to :posts
  end

  private

  def post_params
    params.require(:post).permit(%i[title body])
  end

  def post_id
    params.permit(:id)[:id]
  end
end
