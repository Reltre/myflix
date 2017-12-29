class AddVideoFieldToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :url, :text
  end
end
