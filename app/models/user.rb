class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  def post
    return Post.find_by(post_id: self.post_id)
  end

end
