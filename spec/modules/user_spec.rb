require 'rails_helper'
describe 'Userモデルの単体テスト' do
  describe 'ユーザー登録' do
    it "nameが未入力の場合、登録できない" do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end
  end
end