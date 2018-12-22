class AddOriginTransacitonAndDestinyTransactionToTransfer < ActiveRecord::Migration[5.2]
  def change
    add_reference :transfers, :origin_transfer_id, foreign_key: { to_table: :transactions }, index: true
    add_reference :transfers, :destiny_transfer_id, foreign_key: { to_table: :transactions }, index: true
  end
end
