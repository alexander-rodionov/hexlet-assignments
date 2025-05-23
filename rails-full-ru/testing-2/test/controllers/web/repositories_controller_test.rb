# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one) # Assuming you have a fixture for repositories
    @github_repo_response = {
      name: 'test-repo',
      description: 'A test repository',
      owner: { login: 'test-owner' }
    }.to_json
  end

  test 'should get index' do
    get repositories_url
    assert_response :success
  end

  test 'should get new' do
    get new_repository_url
    assert_response :success
  end

  test 'should show repository' do
    get repository_url(@repository)
    assert_response :success
  end

  test 'should create repository' do
    stub_request(:get, 'https://api.github.com/repos/test-owner/test-repo')
      .to_return(status: 200, body: @github_repo_response, headers: {})

    assert_difference('Repository.count') do
      post repositories_url, params: { repository: { link: 'https://github.com/test-owner/test-repo' } }
    end

    assert_redirected_to repository_url(Repository.last)
  end
end
