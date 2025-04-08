# frozen_string_literal: true

class VacanciesController < ApplicationController
  before_action :param_vacancy_id, only: %i[publish archive]

  def index
    @on_moderate = Vacancy.on_moderate
    @published = Vacancy.published
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)

    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # BEGIN

  def param_vacancy_id
    p 'DO param_vacancy_id'
    @vacancy = Vacancy.find(params.require(:id))
  end

  def publish
    @vacancy.publish!
    redirect_to vacancies_path
  rescue Exception
    redirect_to vacancies_path, alert: 'Can\'t do this'
  end

  def archive
    @vacancy.archive!
    redirect_to vacancies_path
  rescue Exception
    redirect_to vacancies_path, alert: 'Can\'t do this'
  end
  # END

  private

  def vacancy_params
    params.require(:vacancy).permit(:title, :description)
  end
end
