class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン済みのユーザーか判定
  before_action :authenticate_user!

  # サインアップ時にはnameも受け取れるよう設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # nameをparamsに追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
