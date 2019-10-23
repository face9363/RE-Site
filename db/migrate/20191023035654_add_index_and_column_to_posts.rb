class AddIndexAndColumnToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :good, :integer
  end
end
