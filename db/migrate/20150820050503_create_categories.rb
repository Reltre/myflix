class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :video_id
      t.index :video_id
      t.timestamps null: false
    end
  end
end
