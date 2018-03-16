class MoveForeignKeyToVideos < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :video_id
    add_column :videos, :category_id, :integer
  end
end
