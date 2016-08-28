class RenameReviewsColumnDescriptionToContent < ActiveRecord::Migration[5.0]
  def change
    rename_column :reviews, :description, :content
  end
end
