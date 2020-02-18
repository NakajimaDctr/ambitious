class Movie < ApplicationRecord
  # 動画URLは必須
  validates :url, presence: true
  belongs_to :user

  def self.search(params)
    # 検索条件の空チェック → 空でない場合のみ検索条件に追加
    # ユーザーに紐づく動画情報を取得
    movies = self

    # 区分
    if params[:category].present?
      movies = movies.where(category: params[:category])
    end

    # 種目
    if params[:item].present?
      movies = movies.where("item LIKE ?", "%#{params[:item]}%")
    end

    # 学生/プロアマ
    if params[:performer_status].present?
      movies = movies.where(performer_status: params[:performer_status])
    end

    # 演者名
    if params[:performer_name].present?
      # スペース除去
      performer_name = params[:performer_name].gsub(" ", "　");
      movies = movies.where("performer_name LIKE ?", "%#{performer_name}%")
    end

    # 曲名
    if params[:music_title].present?
      movies = movies.where("music_title LIKE ?", "%#{params[:music_title]}%")
    end

    # アーティスト
    if params[:music_artist].present?
      movies = movies.where("music_artist LIKE ?", "%#{params[:music_artist]}%")
    end

    # 出演・受賞
    if params[:performed_at].present?
      movies = movies.where("performed_at LIKE ?", "%#{params[:performed_at]}%")
    end

    # 出演・受賞
    if params[:tags].present?
      movies = movies.where("tags LIKE ?", "%#{params[:tags]}%")
    end

    return movies
  end
end
