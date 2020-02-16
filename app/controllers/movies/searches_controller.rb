class Movies::SearchesController < ApplicationController
  def index
    @movies = current_user.movies.search(search_params)
  end

  private
  def search_params

    # 学生/プロ・アマ
    performer_status = ""
    if params[:performer_status_student] == "1" && params[:performer_status_proama] == "1"
      performer_status = ""
    elsif params[:performer_status_student] == "1"
      performer_status = "学生"
    elsif params[:performer_status_proama] == "1"
      binding.pry
      performer_status = "プロ/アマ"
    end

    params.permit(:category, :item, :performer_name, :music_title, :music_artist, :performed_at, :tags).merge(user_id: current_user.id, performer_status: performer_status)
  end

end
