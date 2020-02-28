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
      it "パスワードが6文字以上の場合、登録できる" do
        # ダミーインスタンス生成
        user = build(:user, password: "123456", password_confirmation: "123456")
        # バリデーション結果の確認
        expect(user).to be_valid
      end
    end

    context '登録失敗' do
      it "nameが未入力の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, name: "")
        # バリデーション実行
        user.valid?
        # エラーメッセージ生成を確認
        expect(user.errors[:name]).to include("を入力してください")
      end

      it "emailが未入力の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, email: "")
        # バリデーション実行
        user.valid?
        # エラーメッセージ生成を確認
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "passwordが未入力の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, password: "")
        # バリデーション実行
        user.valid?
        # エラーメッセージ生成を確認
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "password（確認用）が未入力の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, password_confirmation: "")
        # バリデーション実行
        user.valid?
        # エラーメッセージ生成を確認
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it "passwordが6文字未満の場合、登録できない" do
        # ダミーインスタンス生成
        user = build(:user, password: "12345", password_confirmation: "12345")
        # バリデーション実行
        user.valid?
        # エラーメッセージ生成を確認
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end

      it "nameが重複している場合、登録できない" do
        # ダミーインスタンス生成・登録
        user = create(:user)
        another_user = build(:user, name: user.name, email: "test2@gmail.com")
        # バリデーション実行
        another_user.valid?
        # エラーメッセージ生成を確認
        expect(another_user.errors[:name]).to include("はすでに存在します")
      end

      it "emailが重複している場合、登録できない" do
        # ダミーインスタンス生成・登録
        user = create(:user)
        another_user = build(:user, name: "テスト２", email: user.email)
        # バリデーション実行
        another_user.valid?
        # エラーメッセージ生成を確認
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
    end
  
  end
end