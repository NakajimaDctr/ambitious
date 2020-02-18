class Movies::SearchesController < ApplicationController
  def index
    @movies = current_user.movies.search(params)
    respond_to do |format|
      format.json
    end
  end

end
