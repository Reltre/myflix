class ChangeFollowIdToFollowerId < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :follow_id, :follower_id
  end
end
