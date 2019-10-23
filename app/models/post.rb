class Post < ApplicationRecord

  def public_return
    restricted_data(self, [:id, :longitude, :latitude, :url, :body, :created_at, :user_id, :good_points])
  end

  def public_return_with_user
    {
        post: self.public_return,
        user: User.find(self.user_id).public_return,
    }
  end

  def add_good(user_id)
    gp = GoodPost.new
    gp.user_id = user_id
    gp.post_id = self.id
    if gp.save!
      self.increment!(:good_points)
      return true
    else
      return false
    end
  end
end
