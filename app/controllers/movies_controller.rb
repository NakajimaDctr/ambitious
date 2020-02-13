class MoviesController < ApplicationController

  def index
  end


  def create
    movie = Movie.create(movie_params)
    redirect_to list_path(movie.list_id)
  end

  def edit
    
  end

  def show
    # @movie = Movie.find(params[:id])
  end

  def new
    # @list = List.find(params[:list_id])
    # @movie = Movie.new
  end

  private
  def movie_params
    params.require(:movie).permit(:url, :title).merge(list_id: params[:list_id])
  end
end
