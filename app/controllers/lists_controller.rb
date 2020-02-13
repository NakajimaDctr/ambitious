class ListsController < ApplicationController
  def index 
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    List.create(list_params)
    redirect_to root_path
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to root_path
  end

  private
  def list_params
    params.require(:list).permit(:name);
  end
end
