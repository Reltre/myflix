class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, :leader_id
      t.index [:follower_id, :leader_id], unique: true
    end
  end
end
