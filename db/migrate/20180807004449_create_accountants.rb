class CreateAccountants < ActiveRecord::Migration[5.2]
  def change
    create_table :accountants do |t|
      t.string :name
      t.references :family, foreign_key: true

      t.timestamps
    end
  end
end
