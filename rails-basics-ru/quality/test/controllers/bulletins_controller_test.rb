# test/controllers/bulletins_controller_test.rb
require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  fixtures :bulletins

  test 'should get index' do
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
    assert_select 'a', count: Bulletin.where(published: true).count + 2
  end

  test 'should show published bulletin' do
    bulletin = bulletins(:published_bulletin)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', bulletin.title
    assert_select 'p', bulletin.body
  end

  test 'should show unpublished bulletin' do
    bulletin = bulletins(:unpublished_bulletin)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', bulletin.title
    assert_select 'p', bulletin.body
  end

  test 'should show another published bulletin' do
    bulletin = bulletins(:another_published_bulletin)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', bulletin.title
    assert_select 'p', bulletin.body
  end
end
