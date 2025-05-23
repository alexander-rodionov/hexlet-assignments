# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    repository.fetch! unless repository.fetched?

    begin
      client = Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN', nil))
      github_repo = client.repository(repository.link[%r{.*/(.*/.*)$}, 1])

      repository.update!(
        repo_name: github_repo.name,
        description: github_repo.description,
        owner_name: github_repo.owner.login
      )

      repository.success!
    rescue Octokit::Error => e
      Rails.logger.error "Failed to fetch repository: #{e.message}"

      repository.fail!
    end
  end
end
