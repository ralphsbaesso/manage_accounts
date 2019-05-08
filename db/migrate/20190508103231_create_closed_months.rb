class CreateClosedMonths < ActiveRecord::Migration[5.2]
  def change
    create_table :closed_months do |t|
      t.integer :price_cents
      t.references :account

      t.timestamps
    end
  end
end
