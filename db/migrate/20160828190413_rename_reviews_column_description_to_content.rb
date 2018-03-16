class RenameReviewsColumnDescriptionToContent < ActiveRecord::Migration[5.1]
  def change
    rename_column :reviews, :description, :content
  end
end
