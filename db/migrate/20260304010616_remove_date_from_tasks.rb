class RemoveDateFromTasks < ActiveRecord::Migration[8.1]
  def change
    remove_column :tasks, :date, :date
  end
end
