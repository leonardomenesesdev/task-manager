class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :status
      t.string :end_date
      t.string :date

      t.timestamps
    end
  end
end
