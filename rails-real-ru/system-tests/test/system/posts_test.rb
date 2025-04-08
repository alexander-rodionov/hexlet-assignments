# frozen_string_literal: true

require 'application_system_test_case'
# BEGIN

#Capybara.javascript_driver = :selenium

class PostsTest < ApplicationSystemTestCase

  test 'visit posts' do 
    visit posts_url
    assert_selector 'h1', text: 'Posts'
    assert_selector 'h1', text: 'Posts'
  end

  test 'create post' do
    visit new_post_url
    fill_in('Title', with: 'Some title')
    fill_in('Body', with: 'body ' * 20)
    click_on('Create Post')
    assert_selector('.alert', text:'Post was successfully created.')
  end

  test 'posts listed' do
    visit posts_url
    assert_selector '.table tbody tr td', text:'One'
  end

  test 'posts edit form' do
    visit posts_url
    assert_selector '.table tbody tr td', text: 'Two', match: :first
    click_on 'Edit', match: :first
    assert_selector 'h1', text: 'Editing post'
    click_on 'Back', match: :first
    assert_selector 'h1', text: 'Posts'
  end

  test 'posts edit action' do
    visit posts_url
    assert_selector '.table tbody tr td', text: 'Two', match: :first
    click_on 'Edit', match: :first
    fill_in 'Title', with:'asdasd asd asd'
    click_on 'Update Post', match: :first
    assert_selector 'h1', text: 'asdasd asd asd'
  end


  test 'posts show' do
    visit posts_url
    assert_selector '.table tbody tr td', text: 'Two', match: :first
    click_on 'Show', match: :first
    assert_selector 'h1', text: 'Two'
    click_on 'Edit', match: :first
    assert_selector 'h1', text: 'Editing comment'
    click_on 'Back', match: :first
    assert_selector 'h1', text: 'Two'
  end

  test 'posts delete' do
    visit posts_url
    assert_selector '.table tbody tr td', text: 'Two', match: :first
    click_on 'Destroy', match: :first
    assert accept_alert, 'Are you sure?'
    assert_no_selector '.table tbody tr td', text: 'Two', match: :first
  end


end
# END
