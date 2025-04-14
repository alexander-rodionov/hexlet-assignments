# frozen_string_literal: true

class Web::Movies::ApplicationController < Web::ApplicationController
  helper_method :resource_movie

  def resource_movie
    # BEGIN
    movie_id = params.permit(:movie_id)[:movie_id]
    Movie.find(movie_id)
    # END
  end
end
