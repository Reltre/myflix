class AddFollowIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :follow_id, :integer
  end
end
