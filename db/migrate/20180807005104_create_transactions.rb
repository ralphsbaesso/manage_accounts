class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :date_transaction
      t.decimal :value
      t.string :description
      t.string :title
      t.decimal :amount

      t.timestamps
    end
  end
end
