class DropFollowerIdFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :follower_id
  end
end
