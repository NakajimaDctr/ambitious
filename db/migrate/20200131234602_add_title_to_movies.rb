class AddTitleToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :title, :text
  end
end
