class RemovePolymorphicColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :reviewable_type
    remove_column :reviews, :reviewable_id
  end
end
