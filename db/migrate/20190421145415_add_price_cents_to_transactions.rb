class AddPriceCentsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :price_cents, :integer
  end
end
