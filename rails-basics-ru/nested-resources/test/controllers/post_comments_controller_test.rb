# frozen_string_literal: true

require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    post_attrs = {
      title: Faker::Movies::HarryPotter.character,
      body: Faker::ChuckNorris.fact
    }
    @post = Post.create(post_attrs)
    @comment = @post.post_comments.create comment: 'fake comment'
    @comment_attrs = {
      comment: 'test_comment'
    }
  end

  test 'should comments#create' do
    post post_post_comments_path(@post), params: { post_comment: @comment_attrs }
    assert_redirected_to post_path(@post)
  end

  test 'should comments#edit' do
    get edit_post_post_comment_path(@post, @comment)
    assert_response :success
  end

  test 'should comments#update' do
    put post_post_comment_path(@post, @comment), params: { post_comment: @comment_attrs }
    assert_response :success
  end

  test 'should comments#destroy' do
    delete post_post_comment_path(@post, @comment)
    assert_redirected_to post_path(@post)
  end
end
