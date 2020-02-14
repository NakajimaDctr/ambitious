class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    # 登録が成功したら、一覧画面へ
    if @movie.save
      redirect_to root_path
    else
      # 失敗したら新規登録画面へ（エラー表示）
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
    
  end
  
  def update
    @movie = Movie.find(params[:id])

    # 更新が完了したらindexへ遷移
    if @movie.update(movie_params)
      redirect_to root_path
    else
      # 更新失敗したら更新画面へ遷移
      render :edit
    end
  end

  def destroy

    movie = Movie.find(params[:id])
    # 削除
    movie.destroy
    # indexへ遷移
    redirect_to root_path
  end

  def show
    @movie = Movie.find(params[:id])
  end

  

  private
  def movie_params
    params.require(:movie).permit(:url, :category, :item, :performer_status, :performer_name, :music_title, :music_artist, :performed_at, :tags)
  end
end
