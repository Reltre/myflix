class MoveForeignKeyToVideos < ActiveRecord::Migration
  def change
    remove_column :categories, :video_id
    add_column :videos, :category_id, :integer
  end
end
