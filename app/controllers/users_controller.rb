class UsersController < ApplicationController
  before_action :admin_user, {only: [:index]}

  def admin_user
    if current_user.admin
    else
        flash[:notice] = "権限がありません"
        redirect_to posts_path
    end
  end

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc).page(params[:page]).per(20)
    @post_liked = Like.where(user_id: @user.id)
  end

  def like
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
    @post_liked = Like.where(user_id: @user.id)
    @likes = Like.where(user_id: @user.id).page(params[:page]).per(20)
  end
end
