class CreateSubitems < ActiveRecord::Migration[5.2]
  def change
    create_table :subitems do |t|
      t.string :name
      t.string :description
      t.string :level
      t.string :account_type

      t.timestamps
    end
  end
end
