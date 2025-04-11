# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  # Создавать посты может только залогиненный пользователь, редактировать автор и админ, а удалять - админ. Смотреть могут все.
  def initialize(user, post)
    @user = user
    @post = post
    super
  end

  def logged_in
    !!@user
  end

  def author
    @post.author == @user
  end

  def admin
    !!@user&.admin
  end

  def anyone
    true
  end

  def index
    anyone
  end

  def show
    anyone
  end

  def new?
    logged_in
  end

  def create?
    logged_in
  end

  def edit?
    author || admin
  end


  def update?
    author || admin
  end


  def destroy?
    admin
  end
  # END
end
