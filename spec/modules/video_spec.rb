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

end