class Post < ApplicationRecord

    belongs_to :user
    has_many :likes, dependent: :destroy
    has_one_attached :audio

    validates :title, {presence: true, length: { maximum: 20 }} #投稿のコンテンツにバリデーション
    validates :audio, {presence: true}
    validate :audio_type, :audio_size

    def user
        return User.find_by(id: self.user_id)
    end

    def self.search(keyword)
        where(["title like?", "%#{keyword}%"])
    end

    def audio_type
        if audio.blob
            if !audio.blob.content_type.in?(%('audio/mpeg audio/mp4 audio/x-wav'))
                errors.add(:audio, 'はmp3、wav、m4a形式でアップロードしてください')
            end
        else

        end
    end

    def audio_size
        if audio.blob
            if audio.blob.byte_size > 5.megabytes
                errors.add(:audio, "ファイルを5MB以内にしてください")
            end
        end
    end
end
