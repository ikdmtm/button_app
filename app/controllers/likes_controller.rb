class LikesController < ApplicationController
    before_action :authenticate_user, {only: [:create, :destroy]}
  
    def create
        @like = current_user.likes.create(post_id: params[:post_id])
        @post = Post.find_by(id: params[:post_id])
    end

    def destroy
        @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
        @like.destroy
        @post = Post.find_by(id: params[:post_id])
    end
end
