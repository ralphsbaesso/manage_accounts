class AddInputToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :input, :string
  end
end
