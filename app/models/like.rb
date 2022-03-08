class Like < ApplicationRecord
    belongs_to :post
    belongs_to :user

    validates :post_id, uniqueness: { scope: :user_id } #１ユーザーが１ボタンに１いいね
end
