class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.text :url
      t.string :category
      t.string :item
      t.string :performer_status
      t.string :performer_name
      t.string :music_title
      t.string :music_artist
      t.text :performed_at
      t.text :tags
      t.timestamps
    end
  end
end
