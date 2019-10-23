class AddColumnGoodPoints < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :good_points, :integer, :default => 0
  end
end
