# frozen_string_literal: true

# BEGIN

# END

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    @repository = Repository.new(permitted_params)

    client = Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN', nil))
    github_repo = client.repository(@repository.link[%r{.*/(.*/.*)$}, 1])

    @repository.update!(
      repo_name: github_repo.name,
      description: github_repo.description,
      owner_name: github_repo.owner.login
    )
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
