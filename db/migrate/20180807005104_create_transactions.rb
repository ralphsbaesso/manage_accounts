class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :date_transaction
      t.decimal :value
      t.string :description
      t.string :title
      t.decimal :amount
      t.references :subitem, index: true, foreigen_key: true
      t.references :account, index: true, foreigen_key: true
      t.references :tranfer, index: true, foreigen_key: true

      t.timestamps
    end
  end
end
