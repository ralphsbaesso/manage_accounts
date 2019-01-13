class AddColumnToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :origin, :boolean
  end
end
