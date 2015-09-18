class CreateMyQueue < ActiveRecord::Migration
  def change
    create_table :my_queues do |t|
      t.integer :list_order
      t.integer :user_id
      t.integer :video_id
      
      t.timestamps null: false
    end
  end
end
