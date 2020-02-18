json.array! @movies do |movie|
  json.id movie.id
  json.url movie.url
  json.category movie.category
  json.item movie.item
  json.performer_status movie.performer_status
  json.performer_name movie.performer_name
  json.music_title movie.music_title
  json.music_artist movie.music_artist
  json.performed_at movie.performed_at
  json.tags movie.tags
end