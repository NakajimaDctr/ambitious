require 'rails_helper'
describe 'Userモデルの単体テスト' do
  describe 'ユーザー登録' do

    context '登録成功' do
      it "nameが入力済みの場合、登録できる" do
        # ダミーインスタンス生成
        user = build(:user)
        # バリデーション結果の確認
        expect(user).to be_valid
      end
    end

    context '登録失敗' do
      it "nameが未入力の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, name: nil)
        # バリデーション実行
        user.valid?
        # エラーメッセージを確認
        expect(user.errors[:name]).to include("を入力してください")
      end
    end
  
  end
end