# アプリ名
ambitious（マジック動画管理アプリ）

# 概要
YouTubeにアップロードされているマジック動画のURLとマジック情報（演者名、種目など）を<br>セットで登録・検索できるアプリ

# 本番環境
http://52.198.165.156/

ログイン情報（テスト用）
- Eメール：test@gmail.com
- パスワード：test12345


# 制作背景(意図)
私はマジックが趣味で、Youtube動画をマイリストに登録して視聴しています。<br>
しかしYoutubeのマイリストには検索機能がないため、観たい動画を探すのにマイリスト内をスクロールして探さなければなりません。<br>
マジックの情報（演者名、種目名、曲タイトルなど）を検索条件として検索できるようにすれば、より快適に動画を視聴できると考え、本アプリを開発しました。

# DEMO
#### トップページ（検索結果一覧画面）
<img width="1440" alt="スクリーンショット 2020-03-19 21 22 25" src="https://user-images.githubusercontent.com/60431043/77067241-fe3e8380-6a27-11ea-92e6-dcd84768af86.png">

- 初期表示では未検索状態です。
- 検索条件を変更すると、検索処理が非同期で実行されます。<br>（テキストボックスはフォーカスアウト、ラジオボタン・チェックボックスは選択されたタイミングで検索が実行されます。）

### 新規登録画面
<img width="1440" alt="スクリーンショット 2020-03-20 10 09 20" src="https://user-images.githubusercontent.com/60431043/77128334-0f70aa00-6a93-11ea-921d-3630add66345.png">

- ヘッダーの「＋動画を追加」ボタンをクリックすると、遷移します。<br>
- 動画URL入力欄に一般公開、もしくは限定公開の動画URLを入力後、<br>フォーカスアウトすると、URLからYouTubeの動画IDを取得し、対象の動画が読み込まれます。
- 「登録」ボタンをクリックすると、確認ダイアログが表示され、<br>「OK」をクリックすると対象データが登録されます。（登録後、一覧画面に遷移します。）
- 動画URLと区分（ステージマジック、クロースアップマジック、ジャグリング）は必須項目です。<br>（未入力のまま登録処理を実行するとエラーメッセージが表示されます。）

### 詳細表示画面
<img width="1440" alt="スクリーンショット 2020-03-20 10 24 52" src="https://user-images.githubusercontent.com/60431043/77128841-0f71a980-6a95-11ea-8843-5a0976640380.png">

- 一覧画面の各動画の情報表示エリア（Youtube動画と「編集」ボタンの間のエリア）をクリックすると遷移します。
- 1件詳細表示画面です。（編集はできません。）


### 編集・削除画面
<img width="1440" alt="スクリーンショット 2020-03-20 10 25 35" src="https://user-images.githubusercontent.com/60431043/77128870-2b754b00-6a95-11ea-9912-f1c87de5f65d.png">

- 一覧画面の各動画の「編集」ボタンをクリックすると遷移します。
- 「更新」ボタンをクリックすると確認ダイアログが表示され、「OK」をクリックすると、<br>対象データが更新されます。（更新後、一覧画面に遷移します。）
- 動画URLと区分（ステージマジック、クロースアップマジック、ジャグリング）は必須項目です。<br>（未入力のまま更新処理を実行するとエラーメッセージが表示されます。）
- 「削除」ボタンをクリックすると確認ダイアログが表示され、「OK」をクリックすると、<br>対象データが削除されます。（削除後、一覧画面に遷移します。）


# 工夫したポイント
* 検索機能を非同期化
* YouTubeAPIを使用して、ページ内に動画を埋め込み
* セッションを使用し、他ページへ遷移・操作後、一覧画面に遷移しても検索結果を保つようにしている
* 誤操作防止（新規登録、更新・削除ボタン押下で確認ダイアログを表示）
* Capistranoを使用した自動デプロイ


# 使用技術(開発環境)
## バックエンド
Ruby, Ruby on Rails

## フロントエンド
Haml, Sass, JavaScript, JQuery, Ajax

## データベース
MySQL, SequelPro

## インフラ
AWS(EC2), Capistrano, Docker（開発環境）

## Webサーバ（本番環境）
nginx

## アプリケーションサーバ（本番環境）
unicorn

## ソース管理
GitHub, GitHubDesktop

## テスト
RSpec

## エディタ
 VSCode

# 課題や今後実装したい機能
* 別のユーザーに閲覧権限を付与できる機能
* マイリスト一括登録機能（現状1件ずつしか登録できないため。）
* 画面描画の速度を考慮し、表示時はサムネイル画像を表示させ、サムネイル画像クリック時に動画プレイヤーに変更する。
* タグ登録機能

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
