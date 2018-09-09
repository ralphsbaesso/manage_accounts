class CreateSubitems < ActiveRecord::Migration[5.2]
  def change
    create_table :subitems do |t|
      t.string :name
      t.string :description
      t.string :level
      t.string :account_type
      t.references :item, index: true, foreigen_key: true

      t.timestamps
    end
  end
end
