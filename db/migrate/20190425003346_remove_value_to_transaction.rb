class RemoveValueToTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :value
  end
end
