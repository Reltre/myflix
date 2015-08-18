class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.index :title

      t.text :description
      t.string :small_cover_url
      t.string :large_cover_url
      
      t.timstamps null: false
    end
  end
end
