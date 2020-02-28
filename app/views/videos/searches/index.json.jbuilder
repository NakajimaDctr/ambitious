json.array! @videos do |video|
  json.id video.id
  json.url video.url
  json.category video.category
  json.item video.item
  json.performer_status video.performer_status
  json.performer_name video.performer_name
  json.music_title video.music_title
  json.music_artist video.music_artist
  json.performed_at video.performed_at
  json.tags video.tags
end