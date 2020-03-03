class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:show, :edit, :update]
  before_action :set_params_to_session, only: [:new, :show, :edit]
  def index

    # セッションに検索条件が保存されている場合
    if session[:search_params]

      # セッションからパラメータを取得する
      search_params = session[:search_params]

      # 検索フォーム復元用ハッシュ
      @last_form = search_params

      # 検索用パラメータを作成
      params = create_search_params(search_params)

      # 検索処理
      @videos = Video.search(params)

      # セッション削除
      reset_session

    else
      # セッションに検索条件が保存されていない場合
      # 検索フォーム復元用ハッシュを初期化する
      @last_form = {
        category: '',
        item: '',
        performer_status_student: '',
        performer_status_proama: '',
        performer_name: '',
        music_title: '',
        music_artist: '',
        performed_at: '',
        tags: ''
      }
    end
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    # 登録が成功したら、一覧画面へ
    if @video.save
      redirect_to root_path
    else
      # 失敗したら新規登録画面へ（エラー表示）
      render :new
    end
  end

  def edit
  end
  
  def update
    # 更新が完了したらindexへ遷移
    if @video.update(video_params)
      redirect_to root_path
    else
      # 更新失敗したら更新画面へ遷移
      render :edit
    end
  end

  def destroy
    video = Video.find(params[:id])
    # 削除
    video.destroy
    # indexへ遷移
    redirect_to root_path
  end

  def show
  end

  private
  def video_params
    params.require(:video).permit(:url, :category, :item, :performer_status, :performer_name, :music_title, :music_artist, :performed_at, :tags).merge(user_id: current_user.id)
  end

  def set_video
    @video = Video.find(params[:id])
  end

  # 現在のユーザーと動画に紐づくユーザーが一致しない場合、indexへ遷移させる
  def move_to_index
    user_id = @video.user.id
    redirect_to action: :index if user_id != current_user.id
  end

  # 遷移前の検索条件をハッシュ化し、sessionに格納する
  def set_params_to_session
    session[:search_params] = {
      category: params[:category],
      item: params[:item],
      performer_status_student: params[:performer_status_student],
      performer_status_proama: params[:performer_status_proama],
      performer_name: params[:performer_name],
      music_title: params[:music_title],
      music_artist: params[:music_artist],
      performed_at: params[:performed_at],
      tags: params[:tags]
    }
  end

  # session削除
  def reset_session
    session.delete(:search_params) if session[:search_params]
  end


  # sessionのparamsから検索用のパラメータを作成する
  def create_search_params(session_params)

    # 演技区分の設定
    category = ''
    if session_params['category'] == 'stage'
      category = 'ステージ'
    elsif session_params['category'] == 'close'
      category = 'クロース'
    elsif session_params['category'] == 'juggling'
      category = 'ジャグ'
    end

    # 演者区分の設定
    performer_status = ''
    if session_params['performer_status_student'] == 'true' && session_params['performer_status_proama'] == 'true'
      performer_status = ''
    elsif session_params['performer_status_student'] == 'true'
      performer_status = '学生'
    elsif session_params['performer_status_proama'] == 'true'
      performer_status = 'プロ・アマ'
    end

    # 検索用のパラメータ
    params = {
      category: category,
      item: session_params['item'],
      performer_status: performer_status,
      performer_name: session_params['performer_name'],
      music_title: session_params['music_title'],
      music_artist: session_params['music_artist'],
      performed_at: session_params['performed_at'],
      tags: session_params['tags'],
      user_id: current_user.id
    }
    return params
  end
end
