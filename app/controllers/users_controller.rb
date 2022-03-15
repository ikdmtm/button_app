class UsersController < ApplicationController
  before_action :admin_user, {only: [:index]}
  before_action :ensure_correct_user, {only: [:like]}

  def admin_user
    if current_user.admin
    else
        flash[:notice] = "権限がありません"
        redirect_to posts_path
    end
  end

  def ensure_correct_user #投稿者本人かどうかのチェック
    @user = User.find_by(id: params[:id])
    if current_user
      if @user.id == current_user.id || current_user.admin
      else
        flash[:notice] = "権限がありません"
        redirect_to posts_path
      end
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
    @user_posts = @user.posts #ユーザーの投稿を取得
    @likes_count = 0
    @user_posts.each do |post|
      @likes_count += post.likes.count
    end
  end

  def like
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
    @post_liked = Like.where(user_id: @user.id)
    @likes = Like.where(user_id: @user.id).page(params[:page]).per(20)
    @user_posts = @user.posts #ユーザーの投稿を取得
    @likes_count = 0
    @user_posts.each do |post|
      @likes_count += post.likes.count
    end
  end
end
