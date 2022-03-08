class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def authenticate_user #ユーザーがログインしてない時の処理
        if current_user == nil
            flash[:notice] = "ログインが必要です"
            redirect_to new_user_session_path
        end
    end

    def forbid_login_user #ユーザーがログインしてる時の処理
        if current_user
            flash[:notice] = "すでにログインしています"
            redirect_to posts_path
        end
    end
    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
