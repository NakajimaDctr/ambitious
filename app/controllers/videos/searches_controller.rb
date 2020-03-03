class Videos::SearchesController < ApplicationController
  def index
    params[:user_id] = current_user.id
    @videos = Video.search(params)
    respond_to do |format|
      format.json
    end
  end

end
