class RemoveFieldTransferIdFromTableTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :tranfer_id
  end
end
