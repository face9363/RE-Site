class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true


  def public_return
    restricted_data(self, [:id, :user_id, :email, :image])
  end


end
