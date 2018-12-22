class AddOriginTransacitonAndDestinyTransactionToTransfer < ActiveRecord::Migration[5.2]
  def change
    add_reference :transfers, :origin_transaction, foreign_key: { to_table: :transactions }, index: true
    add_reference :transfers, :destiny_transaction, foreign_key: { to_table: :transactions }, index: true
  end
end
