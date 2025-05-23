# frozen_string_literal: true

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

    if @repository.save
      # Enqueue the RepositoryLoaderJob to fetch repository information
      RepositoryLoaderJob.perform_now(@repository.id)
      redirect_to repositories_path, notice: t('success')
    else
      render :new
    end
  end

  def update
    @repository = Repository.find(params[:id])

    if @repository
      # Enqueue the RepositoryLoaderJob to fetch the latest repository information
      RepositoryLoaderJob.perform_now(@repository.id)
      redirect_to repositories_path, notice: t('success')
    else
      render :edit
    end
  end

  def update_repos
    # Fetch repositories ordered by last update date (oldest first)
    repositories = Repository.order(updated_at: :asc)

    # Enqueue RepositoryLoaderJob for each repository
    repositories.each do |repository|
      RepositoryLoaderJob.perform_now(repository.id)
    end

    redirect_to repositories_path, notice: t('success')
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
