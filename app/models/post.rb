class Post < ApplicationRecord

  def public_return
    restricted_data(self, [:id, :longitude, :latitude, :url, :body, :created_at, :user_id, :good_points])
  end

  def public_return_with_user
    return_data = public_return
    user =  User.find(return_data[:user_id])
    return_data[:user_name] = user.name
    return_data
  end

  def add_good(user_id)
    gp = GoodPost.new
    gp.user_id = user_id
    gp.post_id = self.post_id
    if gp.save!
      self.increment!(:good)
      return true
    else
      return false
    end
  end
end
