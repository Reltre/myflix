class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :description
      t.integer :video_id
      t.timestamps null: false
    end
  end
end
