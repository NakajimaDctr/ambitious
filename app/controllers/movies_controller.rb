class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end


  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    
  end

  def show
    # @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  private
  def movie_params
    params.require(:movie).permit(:url, :category, :item, :performer_status, :performer_name, :music_title, :music_artist, :performed_at, :tags)
  end
end
