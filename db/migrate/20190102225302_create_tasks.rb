class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.boolean :done, default: false
      t.date :due_date
      t.string :type
      t.references :accountant, foreign_key: true

      t.timestamps
    end
  end
end
