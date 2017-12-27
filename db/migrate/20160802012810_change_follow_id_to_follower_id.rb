class ChangeFollowIdToFollowerId < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :follow_id, :follower_id
  end
end
