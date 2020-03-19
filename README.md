# アプリ名
ambitious（マジック動画管理アプリ）

# 概要
YouTubeにアップロードされているマジック動画のURLとマジック情報（演者名、種目など）を登録・検索できるアプリ

# 本番環境
http://52.198.165.156/

ログイン情報（テスト用）
- Eメール：test@gmail.com
- パスワード：test12345


# 制作背景(意図)
私はでマジックが趣味で、Youtube動画をマイリストに登録して視聴しています
しかしYoutubeのマイリストには検索機能がないため、観たい動画を探すのにマイリスト内をスクロールして探さなければなりません。
マジックの情報（演者名、種目名、曲タイトルなど）を検索条件に検索できるようにすれば、より快適に動画を視聴できると考え、本アプリを開発しました。

# DEMO
#### トップページ（検索結果一覧画面）
<img width="1440" alt="スクリーンショット 2020-03-19 21 22 25" src="https://user-images.githubusercontent.com/60431043/77067241-fe3e8380-6a27-11ea-92e6-dcd84768af86.png">

#### 新規登録画面


#### 詳細表示画面

#### 編集・削除画面

# 工夫したポイント
* 開発環境（アプリ本体とMySQL）をDocker-Composeを用いて構築
* 検索機能を非同期化
* YouTubeAPIを使用して、ページ内に動画を埋め込み
* セッションを使用し、他ページへ遷移しても検索結果を保つようにしている
* 誤操作防止機能（新規登録、更新・削除ボタン押下で確認ダイアログを表示）


# 使用技術(開発環境)
## バックエンド
Ruby, Ruby on Rails

## フロントエンド
Haml, Sass, JavaScript, JQuery, Ajax, YouTube Player API

## データベース
MySQL, SequelPro

## インフラ
AWS(EC2), Capistrano, Docker

## Webサーバ（本番環境）
nginx

## アプリケーションサーバ（本番環境）
unicorn

## ソース管理
GitHub, GitHub Desktop

## エディタ
 VSCode

# 課題や今後実装したい機能
* 非公開動画も登録できるようにする。
* 別のユーザーに閲覧権限を付与する。
* マイリスト一括登録機能（現状、1件ずつしか登録できないため。）
* 画面描画の速度を考慮し、サムネイルクリック時のみ動画プレイヤーにする
* CircleCIの導入
* タグ機能

# DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
### Association
- has_many :videos

## videosテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|category|string|null: false|
|item|string||
|performer_status|string||
|performer_name|string||
|music_title|string||
|music_artist|string||
|performed_at|text||
|tags|string||
### Association
- belongs_to :user
