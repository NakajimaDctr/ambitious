class Movies::SearchesController < ApplicationController
  def index
    params[:user_id] = current_user.id
    @movies = current_user.movies.search(params)
    respond_to do |format|
      format.json
    end
  end

end
