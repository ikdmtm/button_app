class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def like
    return Like.find_by(post_id: self.id)
  end
end
