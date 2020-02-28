class Videos::SearchesController < ApplicationController
  def index
    params[:user_id] = current_user.id
    @videos = current_user.videos.search(params)
    respond_to do |format|
      format.json
    end
  end

end
