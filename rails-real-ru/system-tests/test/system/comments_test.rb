# frozen_string_literal: true
require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase

  test 'comment visible ' do
    p posts_url(:one)
    visit post_url(posts(:one))
    assert_selector 'small', text: 'One comment'
    fill_in 'post_comment_body', with: 'Test comment'
    click_on 'Create Comment'
    assert_selector 'small', text: 'Test comment'
  end

  test 'comment create' do
    p posts_url(:one)
    visit post_url(posts(:one))
    fill_in 'post_comment_body', with: 'Test comment'
    click_on 'Create Comment'
    assert_selector 'small', text: 'Test comment'
  end

  test 'comment edit ' do
    p posts_url(:one)
    visit post_url(posts(:one))
    assert_selector 'small', text: 'One comment'
    click_on 'Edit', match: :first
    assert_selector 'h1', text: 'Editing comment'
    fill_in 'post_comment_body', with: 'Changed comment'
    click_on 'Update Comment'
    assert_selector 'small', text: 'Changed comment'
  end

  test 'comment delete ' do
    p posts_url(:one)
    visit post_url(posts(:one))
    assert_selector 'small', text: 'One comment'
    click_on 'Delete', match: :first
    assert accept_alert, 'Are you sure?'
    assert_no_selector 'small', text: 'One comment'
  end

end
