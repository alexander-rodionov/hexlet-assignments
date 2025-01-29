require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_index_url
    assert_response :success
  end

  test "should get show" do
    p 'articles_show_url', articles_show_url
    get articles_show_url
    assert_response :success
  end
end
