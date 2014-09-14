class LessonsController < ApplicationController
  DEFAULT_CURRENT_CATEGORIES_IN = %w(
    vocabulary comprehension speaking pronunciation grammar writing
  )
  DEFAULT_WITH_WATCHED = false

  before_action :authenticate_user!

  def index
    @current_categories_in = params.fetch(:q, {}).fetch(:categories_in, DEFAULT_CURRENT_CATEGORIES_IN)
    @with_watched = params.fetch(:q, {}).fetch(:with_watched, DEFAULT_WITH_WATCHED)
    @lessons = Lesson.categories_in(@current_categories_in)
    unless @with_watched
      watched_lessons = current_user.watched_lessons
      @lessons = @lessons.where.not(id: watched_lessons.pluck(:id))
    end
    @categories = Lesson.pluck(:categories).flatten.uniq
  end

  def watch
    lesson = Lesson.find(params[:id])
    current_user.watched_lessons.push(lesson)
    redirect_to lesson.link
  end
end
