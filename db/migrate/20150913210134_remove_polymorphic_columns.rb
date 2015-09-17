class RemovePolymorphicColumns < ActiveRecord::Migration
  def change
    remove_column :reviews, :reviewable_type
    remove_column :reviews, :reviewable_id
  end
end
