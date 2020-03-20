FactoryBot.define do

  factory :video do
    url              {"https://www.youtube.com/watch?v=ytRDyRvN6gk"}
    category         {"ステージ"}
    item             {"テスト種目"}
    performer_status {"学生"}
    performer_name   {"テスト演者名"}
    music_title      {"テスト曲名"}
    music_artist     {"テストアーティスト"}
    performed_at     {"テスト出演"}
    tags             {"テストタグ"}
    user_id          {1}
  end

end