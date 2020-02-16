class Movies::SearchesController < ApplicationController
  def index
    binding.pry
    @movies = current_user.movies.search(search_params)
  end

  private
  def search_params
    params.permit(:category, :item, :performer_status, :performer_name, :music_title, :music_artist, :performed_at, :tags).merge(user_id: current_user.id)
  end

end
