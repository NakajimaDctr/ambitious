class Video < ApplicationRecord
  # 動画URLは必須
  validates :url, presence: true
  validates :category, presence: true
  belongs_to :user

  def self.search(params)
    # 検索条件の空チェック → 空でない場合のみ検索条件に追加
    # ユーザーに紐づく動画情報を取得
    videos = Video.where(user_id: params[:user_id])

    # 区分
    if params[:category].present?
      videos = videos.where(category: params[:category])
    end

    # 種目
    if params[:item].present?
      videos = videos.where("item LIKE ?", "%#{params[:item]}%")
    end

    # 学生/プロアマ
    if params[:performer_status].present?
      videos = videos.where(performer_status: params[:performer_status])
    end

    # 演者名
    if params[:performer_name].present?
      # スペース除去
      performer_name = params[:performer_name].gsub(" ", "　");
      videos = videos.where("performer_name LIKE ?", "%#{performer_name}%")
    end

    # 曲名
    if params[:music_title].present?
      videos = videos.where("music_title LIKE ?", "%#{params[:music_title]}%")
    end

    # アーティスト
    if params[:music_artist].present?
      videos = videos.where("music_artist LIKE ?", "%#{params[:music_artist]}%")
    end

    # 出演・受賞
    if params[:performed_at].present?
      videos = videos.where("performed_at LIKE ?", "%#{params[:performed_at]}%")
    end

    # 出演・受賞
    if params[:tags].present?
      videos = videos.where("tags LIKE ?", "%#{params[:tags]}%")
    end

    return videos
  end
end
