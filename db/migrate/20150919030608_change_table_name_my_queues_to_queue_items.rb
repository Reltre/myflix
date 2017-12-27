class ChangeTableNameMyQueuesToQueueItems < ActiveRecord::Migration[5.1]
  def change
    rename_table(:my_queues, :queue_items)
  end
end
