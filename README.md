# アプリ名
ambitious（マジック動画管理アプリ）

# 概要
YouTubeにアップロードされているマジック動画のURLとマジック情報（演者名、種目など）を登録できるアプリ

# 本番環境
http://52.198.165.156/

ログイン情報（テスト用）
Eメール：
パスワード：


# 制作背景(意図)
学生のマジックサークルではYouTubeに動画をアップロードし、種目ごとにマイリストを作成してマジック動画を管理している。
しかしYoutubeのマイリストには検索機能がないため、観たい動画を探すのにマイリスト内をスクロールして探さなければならない。
マジックの情報（演者名、種目名、曲タイトルなど）を検索条件に検索できるようにすれば、調べる時間を短縮できると考えて、開発した。

# DEMO
#### トップページ
#### 新規登録画面
#### 詳細表示画面
#### 編集・削除画面

# 工夫したポイント
* 開発環境（アプリ本体と　MySQL）をDocker-Composeを用いて構築
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
