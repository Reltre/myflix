class AddVideoFieldToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :url, :text
  end
end
