class ChangeMoviesToVideos < ActiveRecord::Migration[5.2]
  def change
    rename_table :movies, :videos
  end
end
