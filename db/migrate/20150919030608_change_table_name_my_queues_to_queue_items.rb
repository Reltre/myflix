class ChangeTableNameMyQueuesToQueueItems < ActiveRecord::Migration
  def change
    rename_table(:my_queues, :queue_items)
  end
end
