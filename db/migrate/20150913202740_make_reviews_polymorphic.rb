class MakeReviewsPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :video_id
    add_column :reviews, :reviewable_type, :string
    add_column :reviews, :reviewable_id, :integer
    add_index :reviews, :reviewable_id
  end
end
