require 'rails_helper'
describe 'Videoモデルの単体テスト' do
  describe '動画情報の登録' do

    context '登録成功' do
      example "urlと区分が入力済みの場合、登録できる" do
        user = create(:user)
        video = build(:video)
        expect(video).to be_valid
      end
    end

    context '登録失敗' do
      example "urlが未入力の場合、登録できない" do
        user = create(:user)
        video = build(:video, url: "")
        video.valid?
        expect(video.errors[:url]).to include("を入力してください")
      end

      example "区分が未入力の場合、登録できない" do
        user = create(:user)
        video = build(:video, category: "")
        video.valid?
        expect(video.errors[:category]).to include("を入力してください")
      end

      example "ユーザーが存在しない場合、登録できない" do
        video = build(:video)
        video.valid?
        expect(video.errors[:user]).to include("を入力してください")
      end
    end

  end

  describe '動画情報の検索' do

    context '検索結果：1件' do
      example "ユーザーが登録した動画が存在する場合、検索結果を取得" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id}
        expect(Video.search(params)).to include(video)
      end

      example "区分にマッチする動画が存在する場合、検索結果を取得（完全一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, category: "ステージ"}
        expect(Video.search(params)).to include(video)
      end

      example "種目にマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, item: "テスト"}
        expect(Video.search(params)).to include(video)
      end

      example "演者区分にマッチする動画が存在する場合、検索結果を取得（完全一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performer_status: "学生"}
        expect(Video.search(params)).to include(video)
      end

      example "演者名にマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performer_name: "テスト"}
        expect(Video.search(params)).to include(video)
      end

      example "曲名にマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, music_title: "テスト"}
        expect(Video.search(params)).to include(video)
      end

      example "アーティストにマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, music_artist: "テスト"}
        expect(Video.search(params)).to include(video)
      end

      example "出演・受賞にマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performed_at: "テスト"}
        expect(Video.search(params)).to include(video)
      end

      example "タグにマッチする動画が存在する場合、検索結果を取得（部分一致）" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, tags: "テスト"}
        expect(Video.search(params)).to include(video)
      end

    end

    context '検索結果：0件' do

      example "ユーザーが動画を登録していない場合、検索結果を取得できない" do
        user = create(:user)
        video = create(:video)
        user_another = create(:user, id: 2, name: "テスト2", email: "test2@gmail.com")
        params = {user_id: user_another.id}
        expect(Video.search(params)).to_not include(video)
      end

      example "区分にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, category: "ステージA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "種目にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, item: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "演者区分にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performer_status: "学生A"}
        expect(Video.search(params)).not_to include(video)
      end

      example "演者名にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performer_name: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "曲名にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, music_title: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "アーティストにマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, music_artist: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "出演・受賞にマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, performed_at: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

      example "タグにマッチする動画が存在しない場合、検索結果0件" do
        user = create(:user)
        video = create(:video)
        params = {user_id: user.id, tags: "テストA"}
        expect(Video.search(params)).to_not include(video)
      end

    end
  end
end