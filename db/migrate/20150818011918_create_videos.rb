class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.index :title

      t.text :description
      t.string :small_cover_url
      t.string :large_cover_url

      t.timestamps null: false
    end
  end
end
