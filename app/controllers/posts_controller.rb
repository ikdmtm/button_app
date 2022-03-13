class PostsController < ApplicationController

  before_action :authenticate_user, {only: [:new, :create]} #ログインしていないと新規投稿できない
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]} #本人しか編集、削除ができない


  def ensure_correct_user #投稿者本人かどうかのチェック
    @post = Post.find_by(id: params[:id])
    if current_user
      if @post.user_id == current_user.id || current_user.admin
      else
        flash[:notice] = "権限がありません"
        redirect_to post_path(@post)
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to post_path(@post)
    end
  end

  def search
    @posts = Post.search(params[:keyword]).limit(20)
    @keyword = params[:keyword]
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(30)
  end

  def rank
    @post_like_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(30).pluck(:post_id))
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @post_like_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(10).pluck(:post_id))
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿を作成しました"
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:title, :audio).merge(user_id: current_user.id)
  end
end
