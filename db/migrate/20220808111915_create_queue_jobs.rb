class CreateQueueJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :queue_jobs do |t|
      t.string :title
      t.string :status, default: 'waiting'
      t.string :priority

      t.timestamps
    end
  end
end
