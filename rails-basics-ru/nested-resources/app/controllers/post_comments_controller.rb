# frozen_string_literal: true

class PostCommentsController < ApplicationController
  before_action :acquire_post
  before_action :acquire_comment, except: [:create]
  before_action :acquire_comment_comment, only: %i[update create]

  def create
    @post.post_comments.create(comment: @comment_text)
    redirect_to post_path(@post)
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit; end

  def update
    @comment.update(comment: @comment_text)
    render :edit
  end

  def acquire_post
    @post = Post.find(params.require(:post_id))
  end

  def acquire_comment
    p 'PARAMS', params
    id = if (params.include? :post_comment) && (params.require(:post_comment).include? :id)
           params.require(:post_comment).require(:id)
         else
           params.require(:id)
         end
    @comment = PostComment.find(id)
  end

  def acquire_comment_comment
    @comment_text = params.require(:post_comment).require(:comment)
  end
end
